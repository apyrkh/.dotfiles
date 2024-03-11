# .dotfiles

## git

- `brew install git`

## fish

- install `brew install fish`
- check the fish path with `which fish`, in the examples below it was located at: `/opt/homebrew/bin/fish`.
- add fish to the know shells run the command: `sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'`
- restart your terminal
- set fish as the default shell run the command: `chsh -s /opt/homebrew/bin/fish`
- restart your terminal and check if it launched with fish or not
- add brew binaries in fish path run the command: `fish_add_path /opt/homebrew/bin`

Optionally:
- add auto completions to collect command completions for all commands run: `fish_update_completions`
- edit the `~/.config/fish/config.fish` to have terminal in English `set -x LANG en_US.UTF-8`

Run web interface:
- `fish_config`
