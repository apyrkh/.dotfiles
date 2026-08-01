---
description: Optimize TypeScript code for Bun.js projects — hidden class stability, zero-allocation loops, pre-compiled matchers, GC-friendly string ops. Only apply in Bun.js projects (bun.lock or bunfig.toml present); skip for Node.js projects.
when_to_use: Use when the user asks to "optimize this loop", "make this faster", "reduce allocations", or requests performance improvements on tight loops, parsers, file processors, or hot paths running hundreds+ times. Skip for config files, test helpers, or one-off scripts. Skip entirely if the project uses Node.js instead of Bun.
---

## 1. Runtime-specific APIs (Bun/JSC)

Prefer Bun globals over `node:*` polyfills:

```ts
// ❌
import { readFile } from 'node:fs/promises'
import { join } from 'node:path'
const val = process.env.PORT

// ✅
const file = Bun.file('./data.json')
const path = `${base}/${file}`          // simple paths
const path2 = Bun.path.join(a, b)       // cross-platform paths
const val = Bun.env.PORT
```

---

## 2. Hidden class stability (JIT-friendliness)

JSC creates a hidden class for every object shape. If the shape is stable and
consistent across all creation sites, JSC optimises it as well as a class
instance. Shape instability — adding or deleting properties after creation —
causes a deoptimisation bailout.

```ts
// ❌ Dynamic shape — JSC bails out of optimised code
const obj: any = {}
if (cond) obj.extra = 1          // shape fork
delete obj.name                  // shape change

// ❌ Inconsistent field order between call sites — different hidden classes
const a = { tool: 'x', pattern: null }
const b = { pattern: null, tool: 'x' }  // different shape!

// ✅ Fixed shape — declare all fields at creation time, same order every time
const createRule = (tool: string, pattern: string | null) => ({
  tool,
  pattern,
  enabled: true,   // always present, never added conditionally later
})
```

Rule: **all fields declared at creation, never added or deleted afterward.**
Use `null` / `undefined` as the absent value, not a missing property.

---

## 3. Hot-path iteration

Chainable array methods (`.map`, `.filter`, `.reduce`) and `for...of` allocate
iterators and intermediate arrays — harmless in cold code, costly in tight loops.

```ts
// ❌ Creates two intermediate arrays + iterator
const result = items
  .filter(x => x.active)
  .map(x => x.value)

// ✅ Single pass, zero intermediate allocations
const result: number[] = []
for (let i = 0; i < items.length; i++) {
  if (items[i].active) result.push(items[i].value)
}
```

---

## 4. Memory & GC

**Empty arrays in loops**

```ts
// ❌ Allocates a new array on every call
const getMatches = (items: Item[]) => {
  const out = []          // allocation here
  ...
}

// ✅ Shared constant — reuse or pre-allocate once
const EMPTY: readonly never[] = Object.freeze([])
```

**Avoid `async/await` in tight loops** — each `await` creates a Promise object.
If the work can be synchronous, keep it synchronous.

**Lazy evaluation** — defer expensive work (JSON parsing, complex string
formatting) until the result is actually needed.

---

## 5. String & path operations

```ts
// ❌ split() allocates an array for every call
const parts = path.split('/')
const dir   = parts.slice(0, -1).join('/')

// ✅ indexOf + substring — no intermediate allocations
const slash = path.lastIndexOf('/')
const dir   = path.substring(0, slash)
```

For high-frequency binary/string work, consider a shared `Uint8Array` buffer
instead of creating new strings per iteration.

---

## 6. Pre-compile all matchers

Glob and RegExp compilation is expensive. **Never instantiate inside a loop.**

```ts
// ❌ New Glob on every item
for (const file of files) {
  if (new Bun.Glob('**/*.ts').match(file)) { ... }
}

// ✅ Compile once, reuse
const TS_GLOB = new Bun.Glob('**/*.ts')    // module level
for (const file of files) {
  if (TS_GLOB.match(file)) { ... }
}
```

**Short-circuit check order** — cheapest test first:

1. Strict equality / identity (`rule.tool === toolName`)
2. Boolean flag (`rule.enabled`)
3. Glob / regex match (expensive)

---

## 7. Pre-output checklist

Before writing the final code, answer each question in your reasoning:

- [ ] Did I introduce any new allocations **inside** a hot loop?
- [ ] Are all `Glob` / `RegExp` objects **pre-compiled** at module level?
- [ ] Are all objects / classes **fixed in shape** — no dynamic property adds or deletes?
- [ ] Did I avoid `async/await` inside tight loops where sync is possible?
- [ ] Did I use `indexOf` / `substring` instead of `split` / `slice` where it matters?

If any answer is "no", fix it before outputting.
