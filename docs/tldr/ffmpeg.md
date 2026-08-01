# ffmpeg

Audio/video conversion, compression, and editing.

## Compress a video (H.265/HEVC, QuickTime-compatible)

```bash
ffmpeg -i IMG_4938.MOV -vcodec libx265 -crf 28 -tag:v hvc1 output.mp4
```

- `-crf` (Constant Rate Factor) controls quality/size tradeoff: lower = better quality/bigger file, higher = smaller/lossier. Range ~18-28 is typical; 28 is fairly aggressive.
- `-tag:v hvc1` makes the HEVC output play natively in QuickTime/iOS/Photos (without it, `.mp4` HEVC often shows as a black box or "unsupported").

## Compress with H.264 (max compatibility, larger than HEVC)

```bash
ffmpeg -i input.mov -vcodec libx264 -crf 23 -preset slow output.mp4
```

`-preset` trades encode time for compression efficiency: `ultrafast` → `veryslow`. Slower presets produce smaller files at the same CRF.

## Extract audio only

```bash
ffmpeg -i input.mp4 -vn -acodec copy output.aac
```

## Trim a clip (no re-encoding, fast)

```bash
ffmpeg -i input.mp4 -ss 00:00:10 -to 00:00:30 -c copy output.mp4
```

## Resize / downscale resolution

```bash
ffmpeg -i input.mp4 -vf scale=1280:-2 -vcodec libx265 -crf 28 -tag:v hvc1 output.mp4
```

`scale=1280:-2` sets width to 1280px, height auto-scaled and kept even (required by most codecs).

## Convert video to GIF

```bash
ffmpeg -i input.mp4 -vf "fps=10,scale=480:-1:flags=lanczos" output.gif
```

## Strip audio from a video

```bash
ffmpeg -i input.mp4 -an -vcodec copy output.mp4
```

## Notes

- Check output size: `du -h input.mov output.mp4`
- `-c copy` (stream copy) skips re-encoding — fast and lossless, but only works for operations like trimming/muxing, not resizing/re-compressing.
- Add `-y` to overwrite output files without prompting (careful — no confirmation).
