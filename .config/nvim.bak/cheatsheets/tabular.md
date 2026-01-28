# Tabular Cheat Sheet

Tabular is a vim script for text alignment

## Usage

`:Tab /<character or regex>`, e.g. align by `:`, or `=`, or `|`.

### Atoms:

- `\zs` exclude `character` from match (keep with text)

### Specifiers:

- `/l<N>` - left-align spaces padding
- `/r<N>` - right-align spaces padding
_ `/c<N>` - center-align spaces padding

## Example

`:Tab /|`

```
| Fruit  | Color  |
| -----  | -----  |
| Apple  | Red    |
| Banana | Yellow |
| Kiwi   | Green  |
```
