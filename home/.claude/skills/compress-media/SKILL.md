---
description: Compress or downsize video and PDF files using ffmpeg and ghostscript.
when_to_use: Use when the user asks to compress, shrink, downsize, or re-encode a video or PDF file. Not for images — no image-compression tool is set up yet.
---

# Compress media

Full command reference: `~/.dotfiles/docs/tldr/ffmpeg.md`, `~/.dotfiles/docs/tldr/ghostscript.md`.

## Video (ffmpeg)

Default: H.265/HEVC, QuickTime-compatible.

```bash
ffmpeg -i input.mov -vcodec libx265 -crf 28 -tag:v hvc1 output.mp4
```

- `-crf` trades quality for size: lower = bigger/better, higher = smaller/lossier. ~18-28 typical.
- `-tag:v hvc1` is required for HEVC `.mp4` to play natively in QuickTime/iOS/Photos.
- Need max compatibility over smallest size? Use H.264 instead: `-vcodec libx264 -crf 23 -preset slow`.
- Need a smaller resolution too? Add `-vf scale=1280:-2` (width 1280, height auto, kept even).

Always report `du -h input.mov output.mp4` after, so the user sees the size change.

## PDF (ghostscript)

```bash
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
  -dPDFSETTINGS=/ebook \
  -sOutputFile="compressed.pdf" "input.pdf"
```

`-dPDFSETTINGS` presets, smallest to largest: `/screen` (~72dpi) → `/ebook` (~150dpi, good default) →
`/printer` (~300dpi) → `/prepress` (highest quality). Pick `/ebook` unless the user says otherwise.

Output filename must differ from input — `gs` refuses to overwrite in place.

## Not covered

No image compression tool is installed. `sips` (built-in) resizes/converts formats but does not
meaningfully recompress JPEG/PNG. If the user asks to shrink an image, say so and ask whether to
install `imagemagick` or use `sips` for a resize instead — don't improvise with ffmpeg or ghostscript.
