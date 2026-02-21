#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() {
  printf '\n[install] %s\n' "$1"
}

run_with_elevation() {
  if [[ "${EUID}" -eq 0 ]]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    log "This step needs elevated privileges and sudo was not found."
    return 1
  fi
}

install_vim_linux() {
  if [[ ! -f /etc/os-release ]]; then
    log "Unsupported Linux distribution. Install Vim manually and rerun this script."
    return 1
  fi

  # shellcheck disable=SC1091
  source /etc/os-release

  case "${ID:-}" in
    ubuntu|debian)
      run_with_elevation apt-get update
      run_with_elevation apt-get install -y software-properties-common curl git

      # jonathonf/vim usually provides newer Vim builds for Ubuntu.
      if [[ "${ID}" == "ubuntu" ]] && command -v add-apt-repository >/dev/null 2>&1; then
        run_with_elevation add-apt-repository -y ppa:jonathonf/vim || true
        run_with_elevation apt-get update
      fi

      run_with_elevation apt-get install -y vim
      run_with_elevation apt-get install -y universal-ctags || run_with_elevation apt-get install -y ctags
      ;;
    *)
      log "Linux distro '${ID:-unknown}' is not yet automated. Please install vim, git, curl and ctags manually."
      return 1
      ;;
  esac
}

install_vim_macos() {
  if ! command -v brew >/dev/null 2>&1; then
    log "Homebrew is required on macOS. Install it from https://brew.sh and rerun this script."
    return 1
  fi

  brew update
  brew install vim git curl ctags
  brew upgrade vim || true
}

install_vim_windows() {
  if command -v powershell.exe >/dev/null 2>&1; then
    powershell.exe -NoProfile -Command "if (Get-Command winget -ErrorAction SilentlyContinue) { winget install --id Vim.Vim -e --accept-package-agreements --accept-source-agreements; winget upgrade --id Vim.Vim -e --accept-package-agreements --accept-source-agreements; winget install --id Git.Git -e --accept-package-agreements --accept-source-agreements; winget install --id cURL.cURL -e --accept-package-agreements --accept-source-agreements; winget install --id UniversalCtags.Ctags -e --accept-package-agreements --accept-source-agreements; exit 0 } else { exit 1 }" && return 0
  fi

  if command -v winget >/dev/null 2>&1; then
    winget install --id Vim.Vim -e --accept-package-agreements --accept-source-agreements || true
    winget upgrade --id Vim.Vim -e --accept-package-agreements --accept-source-agreements || true
    winget install --id Git.Git -e --accept-package-agreements --accept-source-agreements || true
    winget install --id cURL.cURL -e --accept-package-agreements --accept-source-agreements || true
    winget install --id UniversalCtags.Ctags -e --accept-package-agreements --accept-source-agreements || true
    return 0
  fi

  if command -v choco >/dev/null 2>&1; then
    choco install -y vim git curl ctags
    choco upgrade -y vim || true
    return 0
  fi

  if command -v scoop >/dev/null 2>&1; then
    scoop install vim git curl ctags
    scoop update vim || true
    return 0
  fi

  log "No supported Windows package manager found (winget/choco/scoop)."
  return 1
}

install_vim_by_platform() {
  local uname_out
  uname_out="$(uname -s)"

  case "${uname_out}" in
    Linux*)
      install_vim_linux
      ;;
    Darwin*)
      install_vim_macos
      ;;
    MINGW*|MSYS*|CYGWIN*|Windows_NT)
      install_vim_windows
      ;;
    *)
      log "Unsupported OS '${uname_out}'."
      return 1
      ;;
  esac
}

install_plugins() {
  mkdir -p ~/.vim/bundle ~/.vim/autoload

  if [[ ! -d ~/.vim/bundle/Vundle.vim ]]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  fi

  curl -fLso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

  cp "${SCRIPT_DIR}/vimrc" ~/.vimrc

  if command -v vim >/dev/null 2>&1; then
    vim +PluginInstall +qall || true
  else
    log "vim binary not found in PATH after installation."
    return 1
  fi

  if [[ -d ~/.vim/bundle/YouCompleteMe ]]; then
    if command -v python3 >/dev/null 2>&1; then
      (
        cd ~/.vim/bundle/YouCompleteMe
        python3 install.py --all
      )
    else
      log "python3 is required to build YouCompleteMe. Install python3 and run: cd ~/.vim/bundle/YouCompleteMe && python3 install.py --all"
      return 1
    fi
  else
    log "YouCompleteMe plugin directory was not found at ~/.vim/bundle/YouCompleteMe"
    return 1
  fi
}

log "Installing/updating Vim and required tools (git, curl, ctags)..."
install_vim_by_platform

log "Applying vim configuration and installing plugins..."
install_plugins

log "Done. Installed Vim version: $(vim --version | head -n 1)"
