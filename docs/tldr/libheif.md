# libheif (`heif-convert`)

Decodes iPhone HEIC/HEIF photos to common formats.

## Convert HEIC to JPEG

```bash
heif-convert input.heic output.jpg
```

Output format is inferred from the filename suffix (`jpg`, `png`, `tif`, `webp`, `y4m` are supported).
If no output filename is given, `.jpg` is used.

## Convert HEIC to PNG

```bash
heif-convert input.heic output.png
```

## Keep EXIF/XMP metadata

```bash
heif-convert --with-exif --with-xmp input.heic output.jpg
```

Metadata is written to sidecar files (`output.exif`, `output.xmp`), not embedded.

## Notes

- `libheif` only decodes/converts — it does not compress. After converting, run the output through
  `jpegoptim` (JPEG) or `pngquant` (PNG) for actual size reduction; see their tldr files.
- `-q` sets JPEG output quality directly, if you don't need a separate jpegoptim pass.
- Check output size: `du -h input.heic output.jpg`
