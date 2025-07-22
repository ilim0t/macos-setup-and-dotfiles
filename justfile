# justfile

# デフォルトタスク：全フェーズを実行
default: setup

# 0) Homebrew インストール（存在しなければ自動で導入）
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

# 0.5) Apple Silicon 上で Rosetta 2 が無ければインストール
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


# 1) Brewfile によるパッケージ一括インストール
install-packages: install-brew install-rosetta
    @echo "🔧 Installing Homebrew packages from Brewfile..."
    brew bundle
    @echo "✅ Packages installed."

# 2) macOS defaults 設定反映
apply-macos:
    @echo "⚙️ Applying macOS defaults..."
    bash macos/defaults.sh
    @echo "✅ macOS defaults applied."

# 3) dotbot を使った設定ファイル同期
link-dotfiles: install-brew
	@echo "📂 Linking dotfiles via dotbot..."
	dotbot -c install.conf.yaml
	@echo "✅ Dotfiles linked."

# 4) Cask 非提供アプリのインストール（.dmg/.pkg）
install-extras:
    @echo "📦 Installing extra apps (.dmg/.pkg)..."
    bash scripts/install-displaylink.sh
    bash scripts/install-realforce.sh
    @echo "✅ Extra apps installed."

# 5) フルセットアップ：上記を順に実行
setup: install-packages apply-macos link-dotfiles install-extras
    @echo "🎉 Full setup complete!"
