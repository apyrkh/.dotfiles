# pngquant

Lossy PNG compression via palette quantization.

## Compress a PNG

```bash
pngquant --quality=65-80 input.png --output output.png
```

- `--quality min-max`: skips the conversion if it can't stay above `min`, uses as few colors as
  possible while staying below `max` (0-100). `65-80` is a reasonable default.
- Without `--output`, pngquant writes `input-fs8.png` next to the original instead of overwriting it.

## Speed / quality trade-off

```bash
pngquant --quality=65-80 --speed 1 input.png --output output.png
```

`--speed`: `1` = slow/best quality, `4` = default, `11` = fastest/roughest.

## Only keep the result if it's actually smaller

```bash
pngquant --quality=65-80 --skip-if-larger input.png --output output.png
```

## Notes

- `--force` overwrites `output.png` if it already exists.
- `--strip` removes metadata (already the default on macOS).
- Check output size: `du -h input.png output.png`
