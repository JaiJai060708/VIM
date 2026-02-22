# Vim setup

This installer supports:
- Ubuntu / Debian (apt + Ubuntu PPA attempt for newer Vim)
- macOS (Homebrew)
- Windows (winget/choco/scoop)

## One-liner install (single line with `&&` between every step)

```sh
git clone https://github.com/swrd06bp/VIM.git && cd VIM && bash install.sh && cd .. && rm -rf VIM
```

## Notes

- The script installs/updates `vim`, `git`, `curl`, and `ctags`.
- On Ubuntu, it attempts `ppa:jonathonf/vim` to get a newer Vim when available.
- On Windows, the script prefers `winget` and will also try `choco` or `scoop`.

## Troubleshooting

- Vundle plugin declarations must use GitHub `owner/repo` format.
- This config uses `Plugin 'greggh/claude.vim'` and `Plugin 'Exafunction/codeium.vim'` for AI assistance and completion.
- After installing plugins, run `:Codeium Auth` in Vim to connect Codeium for completions.
- If `:PluginInstall` fails, ensure your network can reach GitHub and rerun `:PluginInstall`.
