
# Binary, Roman, and Decimal Calculator Project

This project is a collection of calculators built using **Lex** and **Yacc** to process and evaluate expressions in three different numeral systems: **binary**, **Roman numerals**, and **decimal/float numbers**. Each calculator adheres to its respective number format and performs basic arithmetic operations.

## Features

1. **Binary Calculator (`calc_bin.l` and `calc_bin.y`)**
   - Accepts binary numbers as input (e.g., `101`, `1101`).
   - Performs arithmetic operations:
     - Addition (`+`)
     - Subtraction (`-`)
     - Multiplication (`*`)
     - Division (`/`)
   - Supports parentheses for operation precedence.
   - Outputs results in **decimal**.

2. **Roman Numeral Calculator (`calc_rom.l` and `calc_rom.y`)**
   - Accepts Roman numerals as input (e.g., `X`, `IV`, `MMXXV`).
   - Performs the same arithmetic operations as the binary calculator.
   - Outputs results in **Roman numerals**.

3. **Decimal/Float Calculator (`calc_ef.l` and `calc_ef.y`)**
   - Accepts decimal or floating-point numbers (e.g., `3.14`, `2.718`).
   - Supports all arithmetic operations and parentheses.
   - Outputs results in **decimal format**.

## How It Works

1. **Lex**:
   - Tokenizes the input into recognizable components (e.g., numbers, operators, parentheses).
   - Each calculator has its own lexer file (`.l`) tailored for the specific numeral system.

2. **Yacc**:
   - Parses the tokenized input using context-free grammar rules.
   - Evaluates the arithmetic expressions based on operation precedence and associativity.
   - Produces the final output in the required format.

## File Structure

- **Binary Calculator**:
  - `calc_bin.l`: Lexer for binary expressions.
  - `calc_bin.y`: Parser for binary expressions.

- **Roman Numeral Calculator**:
  - `calc_rom.l`: Lexer for Roman numerals.
  - `calc_rom.y`: Parser for Roman numerals.

- **Decimal/Float Calculator**:
  - `calc_ef.l`: Lexer for decimal and floating-point numbers.
  - `calc_ef.y`: Parser for decimal and floating-point numbers.

## Prerequisites

- **Flex**: For lexical analysis.
- **Bison/Yacc**: For syntax analysis.

### Installation
1. Install `flex` and `bison`:
   ```bash
   sudo apt install flex bison
   ```
2. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/calculator-project.git
   cd calculator-project
   ```

## Compilation and Usage

1. **Compile a Calculator**:
   - Example for the binary calculator:
     ```bash
     flex calc_bin.l
     bison -d calc_bin.y
     gcc lex.yy.c calc_bin.tab.c -o calc_bin
     ```

2. **Run the Calculator**:
   - Example for the binary calculator:
     ```bash
     ./calc_bin
     ```

3. **Input Format**:
   - Binary: `101 + 110 * (11 - 10)`
   - Roman: `X + IX / III`
   - Decimal: `3.14 + 2.71 * (1.0 - 0.5)`

## Example Outputs

1. **Binary**:
   - Input: `101 + 11`
   - Output: `10 (Decimal)`

2. **Roman Numerals**:
   - Input: `X + V`
   - Output: `XV`

3. **Decimal**:
   - Input: `3.14 * 2`
   - Output: `6.28`


---

Feel free to contribute, report issues, or request features!
