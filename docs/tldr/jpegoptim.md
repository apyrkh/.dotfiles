# jpegoptim

JPEG compression, lossless or lossy.

## Lossless (safe default, strips only metadata)

```bash
jpegoptim --strip-all --dest=out/ input.jpg
```

- `--dest=<path>`: write to a different directory. **Without it, jpegoptim overwrites the input in
  place** — always pass `--dest` unless overwriting is intended.
- `--strip-all` removes EXIF/comments/other metadata; recompresses losslessly otherwise.

## Lossy (bigger savings, real quality loss)

```bash
jpegoptim --max=85 --strip-all --dest=out/ input.jpg
```

`--max=<0-100>` caps the quality factor and disables lossless mode. `85` is a mild starting point;
lower for smaller files.

## Target a specific file size

```bash
jpegoptim --size=200k --dest=out/ input.jpg
```

`--size` accepts a byte target (`200k`) or a percentage of original size (`50%`); disables lossless mode.

## Notes

- `--totals` prints a summary after a batch run.
- `--threshold=N` skips the file if the size gain is below N percent — useful to avoid degrading
  already-small files for negligible savings.
- Check output size: `du -h input.jpg out/input.jpg`
