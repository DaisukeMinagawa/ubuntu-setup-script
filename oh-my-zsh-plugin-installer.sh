#!/bin/bash

# 完全な Oh My Zshプラグインインストーラー

# Oh My Zshのカスタムプラグインディレクトリ
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# .zshrcファイルのパス
ZSHRC="$HOME/.zshrc"

# インストールするプラグインのリスト
plugins=(
    "aliases"
    "copypath"
    "history"
    "docker"
    "github"
    "composer"
    "laravel"
    "brew"
    "zsh-completions"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)

# プラグインのURLマッピング
declare -A plugin_urls
plugin_urls=(
    ["zsh-completions"]="https://github.com/zsh-users/zsh-completions.git"
    ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
    ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
)

# プラグインのクローンとインストール
for plugin in "${plugins[@]}"; do
    target_dir="$ZSH_CUSTOM/plugins/$plugin"
    if [ -d "$target_dir" ]; then
        echo "プラグイン '$plugin' は既にインストールされています。"
    else
        echo "プラグイン '$plugin' をインストールしています..."
        if [[ -v "plugin_urls[$plugin]" ]]; then
            git clone --depth=1 "${plugin_urls[$plugin]}" "$target_dir"
        else
            git clone --depth=1 "https://github.com/ohmyzsh/ohmyzsh.git" "$target_dir"
            mv "$target_dir/plugins/$plugin"/* "$target_dir"
            rm -rf "$target_dir/plugins"
        fi
        if [ $? -eq 0 ]; then
            echo "プラグイン '$plugin' のインストールが完了しました。"
        else
            echo "プラグイン '$plugin' のインストールに失敗しました。"
            rm -rf "$target_dir"
        fi
    fi
done

# .zshrcファイルにプラグインを追加
echo "プラグインを.zshrcに追加しています..."

# 現在のプラグイン設定を取得
current_plugins=$(grep "^plugins=" "$ZSHRC" | cut -d '(' -f2 | cut -d ')' -f1)

# 新しいプラグインリストを作成
new_plugins="$current_plugins ${plugins[*]}"

# 重複を削除し、整形
new_plugins=$(echo "$new_plugins" | tr ' ' '\n' | sort | uniq | tr '\n' ' ' | sed 's/^ *//' | sed 's/ *$//')

# プラグイン行を更新または追加
temp_file=$(mktemp)
if grep -q "^plugins=" "$ZSHRC"; then
    awk -v new_plugins="$new_plugins" '/^plugins=/{$0="plugins=(" new_plugins ")"} {print}' "$ZSHRC" > "$temp_file"
else
    cp "$ZSHRC" "$temp_file"
    echo "plugins=($new_plugins)" >> "$temp_file"
fi

# zsh-completionsの設定を追加
if ! grep -q "fpath+=.*zsh-completions/src" "$temp_file"; then
    echo 'fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src' >> "$temp_file"
fi

mv "$temp_file" "$ZSHRC"

echo "プラグインの追加が完了しました。"

echo "変更後の.zshrcファイルのプラグイン行:"
grep "^plugins=" "$ZSHRC" || echo "プラグイン行が見つかりません。"

echo "全てのプラグインがインストールされ、.zshrcに追加されました。"
echo "変更を適用するには、以下のコマンドを実行してください："
echo "source $ZSHRC"
