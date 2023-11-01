# Rel

## Description

rel is a tool designed to visualize directory structures and the relationships between specific subdirectories and files. It acts as a wrapper around the tree command, enhancing its functionality and user experience. Here’s how you can install and start using rel:

## Installation

We recommend installing the `rel` CLI tool via Homebrew for easier management, updates, and removals. You can also install it directly using a script if you prefer. Here are the steps for both methods:

### **Recommended: Installation via Homebrew**

1. **Tap the repository:**

    ```bash
    brew tap Yamayamaaya/homebrew-rel
    ```

2. **tool:**

    ```bash
    brew install rel
    ```

Installing via Homebrew allows for easier management of the `rel` tool as a Homebrew formula, enabling straightforward updates and removals using Homebrew commands.

### **Direct Installation**

If you prefer not to use Homebrew, you can install the CLI tool directly using a script:

1. **Download and execute the installation script:**

    ```zsh
    curl -sSL https://raw.githubusercontent.com/Yamayamaaya/Rel/main/install.sh | zsh
    ```

    For bash users:

    ```bash
    curl -sSL https://raw.githubusercontent.com/Yamayamaaya/Rel/main/install.sh | bash
    ```

This command will download the `install.sh` script and execute it, downloading the actual CLI tool, making it executable, and moving it to a directory in your PATH, allowing you to run the tool from anywhere.

## Usage

```bash
rel [-all] [-dir] <target1> <target2> ...
rel <GitHub_Repository_URL> [-all] [-dir] <target1> <target2> ...
```

### **Options:**

-   **-all** : Display the entire directory tree.
-   **-dir** : Focus on directories; only specified files and directories will be displayed.

### **Arguments:**

-   **<GitHub_Repository_URL>** : (Optional) The URL of a public GitHub repository to clone and visualize.
-   **<target1> <target2> ...** : Names of the files or directories to focus on. Both file and directory names can be specified.

### **Examples:**

1. **Visualizing Specific Files and Directories in a Local Directory:**

    ```bash
    rel fileA.js directoryA
    ```

    This command will display the directory structure, focusing on `fileA.js` and `directoryA`, marking them with `<<-`.

2. **Option:**

    ```bash
    rel -dir directoryA fileB.html
    ```

    This command focuses on `directoryA` and `fileB.html`, displaying them along with their hierarchical structures.

3. **Option with Specific Files:**

    ```bash
    rel -all fileC.txt
    ```

    This command displays the entire directory tree and marks `fileC.txt` with `<<-`.

4. **Cloning and Visualizing a GitHub Repository:**

    ```bash
    rel https://github.com/user/repository -all
    ```

    This command clones the specified GitHub repository, displays its entire directory structure, and then removes the cloned repository.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Authors

Yamayamaaya ( yugo139013@gmail.com )
