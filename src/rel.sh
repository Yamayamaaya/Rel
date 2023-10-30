#!/bin/zsh

# Functions

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
        *)
            if [ -z "$SEARCH_PATTERN" ]; then
                tree -F
            else
                tree -F --prune --matchdirs -P "$SEARCH_PATTERN" | sed -E "/($SEARCH_PATTERN)/s//\1 <<-/"
            fi
            ;;
    esac
}

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
        kill -9 $SPIN_PID
        echo -e "\rError: Failed to clone the repository."
        exit 1
    fi

    kill -9 $SPIN_PID
    wait $SPIN_PID 2>/dev/null
    echo -ne "\r\033[K"

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
spin "Searching for files..." & 
SPIN_PID=$!

TEMP_FILE=$(mktemp)
execute_tree > $TEMP_FILE
TREE_OUTPUT=$(< $TEMP_FILE)
rm $TEMP_FILE

kill -9 $SPIN_PID 
wait $SPIN_PID 2>/dev/null
echo -ne "\r\033[K"

echo "$TREE_OUTPUT"

# Cleanup temporary directory if a GitHub repository was cloned
if [[ -n $TEMP_DIR ]]; then
    rm -rf "$TEMP_DIR" || { echo "Error: Failed to remove the temporary directory."; exit 1; }
fi
