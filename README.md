# Rel

### Description

### Installation

To install the CLI tool, you can use the `curl` command to download and execute the installation script directly from the GitHub repository. Run the following command in your terminal:

```zsh
curl -sSL https://raw.githubusercontent.com/Yamayamaaya/Rel/main/install.sh | zsh

```

If you are using bash, run the following command instead:

```bash
curl -sSL https://raw.githubusercontent.com/Yamayamaaya/Rel/main/install.sh |  bash

```

This command will download the install.sh script and execute it, which will then download the actual CLI tool, make it executable, and move it to a directory in your PATH, allowing you to run the tool from anywhere.

### Usage

```bash
rel [-all] [-dir] <target1> <target2> ...
rel <GitHub_Repository_URL> [-all] [-dir] <target1> <target2> ...
```

#### **Options:**

-   **-all** : Display the entire directory tree.
-   **-dir** : Focus on directories; only specified files and directories will be displayed.

#### **Arguments:**

-   **<GitHub_Repository_URL>** : (Optional) The URL of a public GitHub repository to clone and visualize.
-   **<target1> <target2> ...** : Names of the files or directories to focus on. Both file and directory names can be specified.

#### **Examples:**

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

### License

### Authors

-   Yamayamaaya
-   yugo139013@gmail.com
