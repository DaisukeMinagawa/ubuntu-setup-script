#!/bin/bash

# VS Code Laravel 拡張機能インストーラー

# 拡張機能のリスト
extensions=(
    "onecentlin.laravel-blade"
    "onecentlin.laravel5-snippets"
    "amiralizadeh9480.laravel-extra-intellisense"
    "shufo.vscode-blade-formatter"
    "codingyu.laravel-goto-view"
    "stef-k.laravel-goto-controller"
    "naoray.laravel-goto-components"
    "onecentlin.laravel-extension-pack"
    "ctf0.laravel-goto-config"
)

# VS Code がインストールされているか確認
if ! command -v code &> /dev/null
then
    echo "Visual Studio Code がインストールされていません。"
    echo "https://code.visualstudio.com/ からインストールしてください。"
    exit 1
fi

# 拡張機能のインストール
for extension in "${extensions[@]}"
do
    echo "インストール中: $extension"
    code --install-extension "$extension" --force
done

echo "全ての拡張機能のインストールが完了しました。"
echo "VS Code を再起動して、新しい拡張機能を有効にしてください。"
