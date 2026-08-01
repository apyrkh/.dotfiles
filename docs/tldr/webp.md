# webp (`cwebp` / `dwebp`)

Modern image format with strong lossy and lossless compression.

## Convert to WebP (lossy)

```bash
cwebp -q 80 input.png -o output.webp
```

`-q` is quality 0 (poor) to 100 (very good); `80` is the typical default. Works from PNG or JPEG input.

## Lossless WebP

```bash
cwebp -lossless input.png -o output.webp
```

Smaller than PNG at equal quality, but bigger than lossy WebP.

## Decode back to PNG

```bash
dwebp input.webp -o output.png
```

## Notes

- `cwebp -longhelp` lists advanced options (alpha handling, presets, sharpness).
- Not every viewer/tool reads WebP — check the destination supports it before converting a final deliverable.
- Check output size: `du -h input.png output.webp`
