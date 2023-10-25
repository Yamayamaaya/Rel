#!/bin/zsh

# コマンドライン引数が指定されていない場合はエラーメッセージを表示
if [[ $# -eq 0 ]]; then
    echo "Error: No target files specified."
    echo "Usage: $0 <target_file_name1> <target_file_name2> ..."
    exit 1
fi

# 検索パターンを作成
SEARCH_PATTERN=""
for TARGET_FILE in "$@"; do
    SEARCH_PATTERN="$SEARCH_PATTERN|$TARGET_FILE"
done
# 先頭の"|"を削除
SEARCH_PATTERN="${SEARCH_PATTERN:1}"

# 現在のディレクトリからファイルを検索し、ツリー表示
tree -P "$SEARCH_PATTERN" --prune --matchdirs
