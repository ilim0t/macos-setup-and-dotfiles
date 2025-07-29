# ──────────────────────────────────────────────
# Fish の設定ファイル
# ~/.config/fish/config.fish
# ──────────────────────────────────────────────

if command -q brew
    set -gx PATH (brew --prefix)/bin $PATH

    # keg-only な Homebrew Formulaのバイナリを PATH に追加
    set -l keg_only_packages curl unzip trash
    set -l package_prefixes (brew --prefix $keg_only_packages)

    for prefix in $package_prefixes
        fish_add_path -g $prefix/bin
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
