# Dart Cowsay with Fortune

This is a Dart program that uses ASCII art to display a "balloon" around the text it reads from the standard input (stdin). It mimics the popular `cowsay` program, displaying different figures (such as a cow or stegosaurus) along with the text. The program builds a balloon around the input text and optionally lets you choose which figure to display.

The text input can be provided either through a pipe (e.g., `fortune | gocowsay`) or by redirecting input from a file.

## Features

- Reads text input from stdin (e.g., using pipes).
- Wraps the input text inside an ASCII "balloon".
- Supports customizable figures, including `cow` and `stegosaurus`.
- Handles tab characters by converting them to spaces.
- Automatically adjusts the size of the balloon based on the input text width.

## Requirements

- Dart SDK installed on your machine.

## Setup

1. **Install Dart**:
   If you don't already have Dart installed, follow the installation guide here: [Install Dart SDK](https://dart.dev/get-dart).

2. **Clone or Download the Repository**:
   Clone the repository or download the Dart script to your machine.

3. **Run the Program**:
   After installing Dart and setting up the script, run the program using the following command:
   ```bash
   dart run bin/dartcowsay.dart
   ```

## Usage

You can use the program in the following ways:

### With a Pipe (Using `fortune`):

This is the most common usage. For example, use the `fortune` command and pipe its output into the Dart script:

```bash
fortune | dart bin/dartcowsay.dart -f cow
```

This will generate a random fortune and wrap it inside a balloon with the `cow` figure.

### With a File:

You can also pipe content from a file into the Dart script:

```bash
cat your_file.txt | dart bin/dartcowsay.dart -f stegosaurus
```

This will read the contents of `your_file.txt` and wrap it inside a balloon with the `stegosaurus` figure.

### Command-Line Arguments:

- `-f <figure>`: Allows you to choose which figure to display. The available figures are:
  - `cow` (default)
  - `stegosaurus`

Example:

```bash
dart bin/dartcowsay.dart -f stegosaurus
```

If no figure is specified, the default figure is `cow`.

### Output Example:

For example, the following command:

```bash
fortune | dart bin/dartcowsay.dart -f cow
```

Would output something like this:

```
 __________________
/ Hello, world!   \
|                   |
\___________________/
         \  ^__^
          \ (oo)\_______
	    (__)\       )\/\
	        ||----w |
	        ||     ||
```

## Code Breakdown

### 1. **`buildBalloon`**:
   This function takes a list of lines and a `maxwidth`, and wraps the text inside a "balloon" with borders at the top, bottom, and sides.

### 2. **`tabsToSpaces`**:
   Converts any tabs in the text to 4 spaces to ensure proper alignment when calculating the width of the lines.

### 3. **`calculateMaxWidth`**:
   Determines the maximum width of the lines, used for formatting the balloon.

### 4. **`normalizeStringsLength`**:
   Adds spaces to shorter lines so that all lines have the same width, ensuring that the balloon is well-aligned.

### 5. **`printFigure`**:
   Prints the figure (either `cow` or `stegosaurus`) below the text balloon.

### 6. **Command-line Arguments**:
   The program uses `-f` to specify the figure to use (either `cow` or `stegosaurus`).
