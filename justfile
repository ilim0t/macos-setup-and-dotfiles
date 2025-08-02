default:
    @just --list

# Homebrew インストール（存在しなければ自動で導入）
install-brew:
    #!/usr/bin/env bash
    echo "🍺 Checking for Homebrew..."
    if command -v brew >/dev/null 2>&1; then
        echo "→ Homebrew already installed, skipping"
        exit 0
    fi
    echo "→ Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "✅ Homebrew installation complete."

# Apple Silicon 上で Rosetta 2 が無ければインストール
install-rosetta:
    #!/usr/bin/env bash
    echo "⚙️  Checking Rosetta 2 (Intel バイナリ互換)..."
    if [[ "$(uname -m)" == "arm64" ]] && ! pgrep oahd >/dev/null 2>&1; then
        echo "→ Installing Rosetta 2..."
        sudo softwareupdate --install-rosetta --agree-to-license
    else
        echo "→ Rosetta 2 already installed or not needed."
    fi
    echo "✅ Rosetta 2 status OK."

# Brewfile によるパッケージ一括インストール
install-packages: install-brew install-rosetta
    @echo "🔧 Installing Homebrew packages from Brewfile..."
    brew bundle
    @echo "✅ Packages installed."

# macOS defaults 設定反映
apply-macos:
    @echo "⚙️ Applying macOS defaults..."
    bash macos/defaults.sh
    @echo "✅ macOS defaults applied."

# dotbot を使った設定ファイル同期
link-dotfiles: install-brew
    @echo "📂 Linking dotfiles via dotbot..."
    dotbot -c install.conf.yaml
    @echo "✅ Dotfiles linked."

# Fish shellの設定
setup-fish: install-packages
    #!/usr/bin/env bash
    echo "🐟 Setting up Fish shell..."
    if ! grep -q "$(brew --prefix)/bin/fish" /etc/shells; then
        echo "→ Adding Fish to /etc/shells (requires sudo)..."
        echo "$(brew --prefix)/bin/fish" | sudo tee -a /etc/shells
    fi
    if [[ "$SHELL" != "$(brew --prefix)/bin/fish" ]]; then
        echo "→ Changing default shell to Fish (requires password)..."
        chsh -s "$(brew --prefix)/bin/fish"
    fi
    echo "✅ Fish shell setup complete!"

# フルセットアップ：上記を順に実行
setup: install-packages apply-macos link-dotfiles setup-fish
    @echo "🎉 Full setup complete!"
