# Setup Environment

macOS の開発環境セットアップを自動化するスクリプト群です。

## 機能

- 🍺 Homebrew パッケージの一括インストール
- ⚙️ macOS システム設定の自動構成
- 📂 dotfiles の自動配置

## 必要条件

- macOS
- git

## セットアップ方法

1. リポジトリをクローン:
```bash
git clone https://github.com/ilim0t/setup-env.git
cd setup-env
```

2. 一時的な `just` バイナリのインストール:
```bash
# 一時的な just バイナリのインストール
mkdir -p .tmp/bin
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to .tmp/bin
export PATH="$PWD/.tmp/bin:$PATH"
```

3. セットアップの実行:
```bash
just setup
```

これにより以下が順に実行されます:
1. Homebrew のインストール（必要な場合）
2. Rosetta 2 のインストール（Apple Silicon の場合）
3. Brewfile からパッケージの一括インストール
4. macOS のシステム設定の適用
5. dotfiles の配置

## 個別のタスク実行

特定の設定のみを適用したい場合は、以下のコマンドを使用できます:

```bash
just install-brew     # Homebrew のインストールのみ
just install-rosetta  # Rosetta 2 のインストールのみ
just install-packages # パッケージのインストールのみ
just apply-macos      # macOS 設定の適用のみ
just link-dotfiles    # dotfiles の配置のみ
just setup-fish       # Fish のログインシェル化 + プラグイン同期
```

## ファイル構成

- `Brewfile` - インストールするパッケージの一覧
- `install.conf.yaml` - dotbot の設定ファイル
- `justfile` - タスクランナーの設定
- `MANUAL_SETUP.md` - 手動で行う必要のある設定の手順
- `dotfiles/` - 各種設定ファイル
- `macos/` - macOS 関連の設定
  - `defaults.sh` - macOS システム設定スクリプト

## 技術スタック

- [Homebrew](https://brew.sh) - パッケージマネージャー
- [just](https://github.com/casey/just) - タスクランナー
- [dotbot](https://github.com/anishathalye/dotbot) - dotfiles マネージャー
