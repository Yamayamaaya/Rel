## Rel

### Description

### Installation

To install the CLI tool, you can use the `curl` command to download and execute the installation script directly from the GitHub repository. Run the following command in your terminal:

```zsh
curl -sSL https://raw.githubusercontent.com/Yamayamaaya/Rel/main/install.sh | zsh

```

If you are using bash, run the following command instead:

```bash
curl -sSL https://raw.githubusercontent.com/Yamayamaaya/Rel/main/install.sh |  | bash

```

This command will download the install.sh script and execute it, which will then download the actual CLI tool, make it executable, and move it to a directory in your PATH, allowing you to run the tool from anywhere.

### Usage

To use the CLI tool, you can run the rel command followed by the names of the files you want to search for. Here is the basic syntax:

```bash
rel filename1 filename2 ...
```

Examples:

-   To search for a single file:

    ```bash
    rel file1.txt
    ```

-   To search for multiple files:

    ```bash
    rel file1.txt file2.txt file3.txt
    ```

The `rel` command will display a tree structure showing the locations of the specified files within the directory hierarchy.

### Contributing

### License

### Authors

### Acknowledgments

### Reporting Bugs
