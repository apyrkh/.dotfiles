# ghostscript (`gs`)

PostScript/PDF interpreter. Installed via Brewfile.

## Compress a PDF

```bash
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
  -dPDFSETTINGS=/ebook \
  -sOutputFile="compressed.pdf" "input.pdf"
```

`-dPDFSETTINGS` presets (trade quality for size):

| Preset | Use case |
|---|---|
| `/screen` | Smallest, ~72dpi, screen-only viewing |
| `/ebook` | Good default, ~150dpi, readable on-screen |
| `/printer` | ~300dpi, higher quality for printing |
| `/prepress` | Highest quality, color-preserving |

## Manual image downsampling (finer control than a preset)

```bash
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
  -dDownsampleColorImages=true -dColorImageResolution=110 \
  -dDownsampleGrayImages=true -dGrayImageResolution=110 \
  -sOutputFile="compressed.pdf" "input.pdf"
```

Lower the `*Resolution` values for smaller files at the cost of image quality.

## Notes

- `-dQUIET -dBATCH -dNOPAUSE` suppress prompts/banners for non-interactive use.
- Output and input filenames must differ — `gs` will not overwrite the input in place.
- Check size before/after: `du -h input.pdf compressed.pdf`
