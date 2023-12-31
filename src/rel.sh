#!/bin/zsh

# Functions

# シグナルハンドラ
cleanup() {
    # 一時ディレクトリが存在する場合は削除
    [[ -n $TEMP_DIR ]] && rm -rf "$TEMP_DIR"
    # スピンローダーのプロセスが存在する場合は終了
    [[ -n $SPIN_PID ]] &&  end_spin $SPIN_PID
    echo "Exiting."
    exit 1
}



spin() {
    local message=$1
    local -a spinner=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    while true; do
        for i in "${spinner[@]}"; do
            echo -ne "\r$i $message"
            sleep 0.1
        done
    done
}

end_spin() {
    local SPIN_PID=$1
    kill $SPIN_PID
    sleep 1
    kill -9 $SPIN_PID 2>/dev/null
    echo -ne "\r\033[K"
}

show_help() {
    echo "Usage: rel [-h] [-all] [-dir] [<GitHub_Repository_URL>] <target1> <target2> ..."
    echo ""
    echo "Options:"
    echo "  -h                  Show this help message and exit."
    echo "  -all                Display the entire directory tree."
    echo "  -dir                Focus on directories; only specified files and directories will be displayed."
    echo ""
    echo "Arguments:"
    echo "  <GitHub_Repository_URL>  (Optional) The URL of a public GitHub repository to clone and visualize."
    echo "  <target1> <target2> ...  Names of the files or directories to focus on. Both file and directory names can be specified."
}

execute_tree() {
    case $OPTION in
        -all)
            if [ -z "$SEARCH_PATTERN" ]; then
                tree -F
            else
                tree -F | sed -E "/($SEARCH_PATTERN)/s//\1 <<-/"
            fi
            ;;
        -dir)
            if [ -z "$SEARCH_PATTERN" ]; then
                tree -F -d
            else
                tree -F -P "$SEARCH_PATTERN" --matchdirs | sed -E "/($SEARCH_PATTERN)/s//\1 <<-/"
            fi
            ;;
        -h)
            show_help
            ;;
        *)
            if [ -z "$SEARCH_PATTERN" ]; then
                tree -F
            else
                tree -F --prune --matchdirs -P "$SEARCH_PATTERN" | sed -E "/($SEARCH_PATTERN)/s//\1 <<-/"
            fi
            ;;
    esac
}

# SIGINTシグナル（Ctrl+C）を受信した場合にcleanup関数を実行
trap cleanup SIGINT

# Check if 'tree' command is installed
if ! command -v tree &> /dev/null; then
    echo "Error: The 'tree' command is not installed."
    exit 1
fi

# Check if a GitHub repository URL is provided
if [[ $1 == https://github.com/* ]]; then
    REPO_URL=$1
    shift

    TEMP_DIR=$(mktemp -d)
    spin "Fetching data by cloning the repository..." &
    SPIN_PID=$!

    if ! git clone --quiet "$REPO_URL" "$TEMP_DIR"; then
        end_spin $SPIN_PID
        echo -e "\rError: Failed to clone the repository."
        exit 1
    fi

    end_spin $SPIN_PID

    cd "$TEMP_DIR" || { echo "Error: Failed to change directory."; exit 1; }
fi

# Validate command-line arguments
if [[ $# -eq 0 ]]; then
    echo "Error: No options or target files specified."
    echo "Usage: $0 [-all] [-dir] <target_file_name1> <target_file_name2> ..."
    exit 1
fi

# Parse options or filenames
if [[ $1 == -* ]]; then
    OPTION=$1
    shift
fi

SEARCH_PATTERN=""
for TARGET_FILE in "$@"; do
    SEARCH_PATTERN="$SEARCH_PATTERN|$TARGET_FILE"
done
SEARCH_PATTERN="${SEARCH_PATTERN:1}"

# Display spinner while searching for files
if [[ $OPTION == -h ]]; then
    spin "Loading..." &
else
    spin "Searching for files..." &
fi

SPIN_PID=$!

TREE_OUTPUT=$(execute_tree)

end_spin $SPIN_PID

echo "$TREE_OUTPUT"

# Cleanup temporary directory if a GitHub repository was cloned
if [[ -n $TEMP_DIR ]]; then
    rm -rf "$TEMP_DIR" || { echo "Error: Failed to remove the temporary directory."; exit 1; }
fi
