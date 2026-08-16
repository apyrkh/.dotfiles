# tldr notes

Quick usage examples for installed CLI tools. Each file is self-contained: pick the one for the
tool you need, the commands work as-is.

## Developer Tools

- `gh` — [gh.md](gh.md)

## Compress or convert media

| Input                | Read                             |
| ---                  | ---                              |
| `.mp4` `.mov` `.mkv` | [ffmpeg.md](ffmpeg.md)           |
| `.pdf`               | [ghostscript.md](ghostscript.md) |
| `.png`               | [pngquant.md](pngquant.md)       |
| `.jpg` `.jpeg`       | [jpegoptim.md](jpegoptim.md)     |
| `→ .webp`            | [webp.md](webp.md)               |
| `.heic`              | [libheif.md](libheif.md)         |

`.heic` is two steps: libheif only decodes, it doesn't compress. Convert with libheif.md, then use
the row above for the format you converted to.

General rules that apply regardless of tool: check size before/after with `du -h`, and don't
overwrite the input file unless you mean to.

No resize/scaling tool is set up. None of the tools above change an image's dimensions.
