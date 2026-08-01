#!/usr/bin/env node
// ─── Hook payload schema (Claude Code StopHook, as of v2.1.193) ───────────────
// To re-inspect the live payload, temporarily add to the main block:
//   const F = '/tmp/statusline-debug.json';
//   const sz = require('fs').existsSync(F) ? require('fs').statSync(F).size : 0;
//   if (sz < 100) require('fs').writeFileSync(F, JSON.stringify(data, null, 2));
// Then trigger any response and read /tmp/statusline-debug.json.
//
// Top-level fields used here:
//   data.session_id          — unique session UUID
//   data.transcript_path     — ~/.claude/projects/<project>/<session-id>.jsonl
//                              subagents live at <transcript_path without .jsonl>/subagents/
//   data.model.id            — e.g. "claude-sonnet-4-6"
//   data.model.display_name  — e.g. "Sonnet 4.6"
//   data.workspace.repo.name — git repo name (absent for non-git dirs)
//   data.workspace.project_dir  — session root, stable (set at start, ignores cd)
//   data.workspace.current_dir  — actual cwd, changes with cd
//   data.cost.total_cost_usd — cumulative USD for session incl. all subagents
//   data.context_window.used_percentage
//   data.context_window.total_input_tokens
//   data.context_window.context_window_size
//   data.context_window.current_usage.{input,output,cache_creation_input,cache_read_input}_tokens
// ─────────────────────────────────────────────────────────────────────────────
// ─── ANSI helpers ─────────────────────────────────────────────────────────────
const R    = '\x1b[0m';
const DIM  = '\x1b[2m';
const BOLD = '\x1b[1m';
const c    = n => `\x1b[38;5;${n}m`;

const COL_LABEL  = DIM  + c(245);
const COL_BAR_HI = c(75);
const COL_BAR_LO = c(237);
const COL_PCT    = BOLD + c(255);
const COL_VAL    = c(252);
const COL_WARM   = c(214);
const COL_COLD   = c(117);
const COL_MODEL  = BOLD + c(39);
const COL_REPO   = BOLD + c(255);
const COL_COST   = c(185);

// ─── Column layout constants ───────────────────────────────────────────────────
const IND      = '  ';   // 2-space left indent on every line
const SEP      = '  ';   // column separator
const LABEL_W  = 5;      // widest label is "cache" = 5 chars
const BAR_W    = 20;     // full bar visual width
const PCT_W    = 4;      // widest pct is "100%" = 4 chars

// ─── Helpers ──────────────────────────────────────────────────────────────────
// Pad label to LABEL_W BEFORE adding color so padEnd works on plain chars.
function label(s) {
    return COL_LABEL + s.padEnd(LABEL_W) + R;
}

// Normal progress bar: filled ═ + dim ═, always BAR_W visual chars.
function bar(pct) {
    const n = Math.round(Math.max(0, Math.min(100, pct || 0)) / 100 * BAR_W);
    return COL_BAR_HI + '═'.repeat(n) + COL_BAR_LO + '═'.repeat(BAR_W - n) + R;
}

// Right-justify pct to PCT_W chars BEFORE adding color.
function pct(n) {
    return COL_PCT + (Math.round(n || 0) + '%').padStart(PCT_W) + R;
}

function fmtK(n) {
    if (n == null || isNaN(n)) return '?';
    return n >= 1000 ? (n / 1000).toFixed(1) + 'k' : String(n);
}

function fmtCost(usd) {
    if (usd == null || isNaN(usd)) return null;
    return '$' + usd.toFixed(4);
}


// ─── Main ─────────────────────────────────────────────────────────────────────
let input = '';
process.stdin.on('data', chunk => input += chunk);
process.stdin.on('end', () => {
    const data = JSON.parse(input);

    const repoName = data.workspace?.repo?.name
        || (data.workspace?.project_dir || data.workspace?.current_dir || data.cwd || process.cwd()).split('/').filter(Boolean).pop()
        || 'unknown';
    const model    = data.model?.display_name || data.model?.id || 'unknown';

    const cw         = data.context_window || {};
    const usedPct    = cw.used_percentage ?? 0;
    const totalInput = cw.total_input_tokens || 0;
    const windowSize = cw.context_window_size || 0;
    const usage      = cw.current_usage || null;

    const cacheRead  = usage?.cache_read_input_tokens       || 0;
    const cacheWrite = usage?.cache_creation_input_tokens   || 0;

    const ctxPct   = Math.round(usedPct);

    const cost     = data.cost?.total_cost_usd ?? null;
    const costStr  = fmtCost(cost);

    // ── Line 1: repo  model  cost ─────────────────────────────────────────────
    const line1 = IND + COL_REPO + repoName + R + SEP + COL_MODEL + model + R
        + (costStr ? SEP + COL_COST + costStr + R : '');

    // ── Line 2: ctx  bar  pct  tokens/total  [Xk warm / Yk cold] ───────────────
    const line2 = IND
        + label('ctx')
        + SEP + bar(ctxPct)
        + SEP + pct(ctxPct)
        + SEP + COL_VAL + fmtK(totalInput) + '/' + fmtK(windowSize) + R
        + SEP + COL_LABEL + '[' + R
        + COL_WARM + fmtK(cacheRead)  + R + COL_LABEL + ' warm / ' + R
        + COL_COLD + fmtK(cacheWrite) + R + COL_LABEL + ' cold]'   + R;

    process.stdout.write([line1, line2].join('\n') + '\n');
});
