---
description: Compress or downsize video, PDF, and image (PNG/JPEG/WebP/HEIC) files.
when_to_use: Use when the user asks to compress, shrink, downsize, or re-encode a video, PDF, or image file.
---

# Compress media

This skill is a router, not a manual. All commands live in `~/.dotfiles/docs/tldr/`.

**Read only the one tldr file that matches the input format. Do not read the others** — each file is
self-contained and loading more than one wastes context for no benefit.

| Input | Read only |
|---|---|
| `.mp4` `.mov` `.mkv` video | `~/.dotfiles/docs/tldr/ffmpeg.md` |
| `.pdf` | `~/.dotfiles/docs/tldr/ghostscript.md` |
| `.png` | `~/.dotfiles/docs/tldr/pngquant.md` |
| `.jpg` `.jpeg` | `~/.dotfiles/docs/tldr/jpegoptim.md` |
| convert to `.webp` | `~/.dotfiles/docs/tldr/webp.md` |
| `.heic` | `~/.dotfiles/docs/tldr/libheif.md` first (decode), then the row above for whatever format you decoded to (compress) |

## Rules

- Always report size before/after with `du -h`, so the user sees the actual saving.
- Never overwrite the input file in place without asking first.

## Limits

No resize/scaling tool is set up. If asked to resize or downscale an image's dimensions, say so plainly
and stop — don't substitute ffmpeg, ghostscript, or any of the tools above; none of them resize images.
