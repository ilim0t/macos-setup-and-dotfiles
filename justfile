# justfile

# デフォルトタスク：全フェーズを実行
default: setup

# 0) Homebrew インストール（存在しなければ自動で導入）
install-brew:
    @echo "🍺 Checking Homebrew..."
    command -v brew >/dev/null 2>&1 || /bin/bash -c "\
      $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # M1/M2/M4 の場合は環境をシェルに反映
    eval "$$(/opt/homebrew/bin/brew shellenv)"
    @echo "✅ Homebrew is ready."

# 1) Brewfile によるパッケージ一括インストール
install-packages: install-brew
    @echo "🔧 Installing Homebrew packages..."
    brew bundle --file=Brewfile
    @echo "✅ Packages installed."

# 2) macOS defaults 設定反映
apply-macos:
    @echo "⚙️  Applying macOS defaults..."
    bash macos/defaults.sh
    @echo "✅ macOS defaults applied."

# 3) dotbot を使った設定ファイル同期
link-dotfiles:
    @echo "📂 Linking dotfiles via dotbot..."
    bash scripts/install-dotfiles.sh
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
