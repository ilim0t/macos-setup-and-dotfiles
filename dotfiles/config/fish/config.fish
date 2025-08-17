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
    # エディタ設定
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    
    set -g theme_color_scheme solarized
    set -g fish_prompt_pwd_dir_length 0

    # Commands to run in interactive sessions can go here
end
