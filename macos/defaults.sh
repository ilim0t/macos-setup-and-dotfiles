#!/usr/bin/env bash
set -euxuo pipefail

# ┌──────────────────────────────────────
# │ Dock 関連設定
# └──────────────────────────────────────
# 自動的に Dock を隠す
defaults write com.apple.dock autohide -bool true
# Dock が隠れるまでの遅延をゼロに
defaults write com.apple.dock autohide-delay -float 0
# 隠れる・現れるアニメーションの速度を調整
defaults write com.apple.dock autohide-time-modifier -float 0.5
# Dock アイコンをマウスホバーで拡大する
defaults write com.apple.dock magnification -bool true
# 拡大時のアイコンサイズを 96px に設定
defaults write com.apple.dock largesize -int 96

# ┌──────────────────────────────────────
# │ メニューバー＆時計設定
# └──────────────────────────────────────
# メニューバーの時計に秒表示を有効化
defaults write com.apple.menuextra.clock ShowSeconds -bool true
# Bluetooth アイコンをメニューバーに「表示する」設定に変更
defaults -currentHost write com.apple.controlcenter.plist Bluetooth -int 18

# ┌──────────────────────────────────────
# │ Finder 表示設定
# └──────────────────────────────────────
# Finder でファイル拡張子を常に表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Finder のウィンドウにパスバーを表示
defaults write com.apple.finder ShowPathbar -bool true

# ┌──────────────────────────────────────
# │ トラックパッド＆スワイプ設定
# └──────────────────────────────────────
# ２本指スワイプでブラウザや Finder の前後履歴を移動
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
# ３本指水平スワイプを無効化（４本指専用の設定に干渉しないように）
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
# # ４本指水平スワイプで Spaces（フルスクリーンアプリ切替）を有効化
# defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
# # ４本指垂直スワイプで Mission Control を有効化
# defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2

# ┌──────────────────────────────────────
# │ システム全体設定
# └──────────────────────────────────────
# 起動音（チャイム）をミュートに設定
sudo nvram StartupMute=%01

# ┌──────────────────────────────────────
# │ プロセス再起動
# └──────────────────────────────────────
# Dock, メニューバー, Finder を再起動して設定を反映
killall Dock           || true
killall SystemUIServer || true
killall Finder         || true
killall ControlCenter  || true
