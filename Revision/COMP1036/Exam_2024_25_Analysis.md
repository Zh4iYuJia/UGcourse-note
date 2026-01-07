# COMP1036 Autumn 2024/25 试卷分析与解析

这份 2024/25 秋季学期的考卷总分 50 分，结构与往年真题非常相似，考查了从硬件层（补码、逻辑门）到软件层（汇编、VM）的全部核心知识点。

## Question 1: Logic & Hardware (25 Marks)

**考察重点**: 2的补码运算、布尔代数简化、逻辑门真值表、组合逻辑芯片。

### (a) 8-bit Two's Complement to Decimal (3 marks)
**规则**: 首位为1是负数（取反加1），首位为0是正数。
*   **a = 1011 0100** (首位1，负数)
    *   取反: `0100 1011` -> 64+8+2+1 = 75
    *   加1: 76
    *   Result: **-76**
*   **b = 0010 1111** (首位0，正数)
    *   32 + 8 + 4 + 2 + 1 = 47
    *   Result: **47**
*   **c = 1111 1111** (首位1，负数)
    *   这是一个特殊值，代表 -1 (或者: 取反`00000000` -> 0, 加1 -> 1, 结果 -1)
    *   Result: **-1**

### (b) Decimal to 8-bit Two's Complement (3 marks)
**规则**: 正数直接转；负数先转正数二进制，取反，加1。
*   **a = -113**
    *   113 = 64+32+16+1 -> `0111 0001`
    *   取反: `1000 1110`
    *   加1: **`1000 1111`**
*   **b = -87**
    *   87 = 64+16+4+2+1 -> `0101 0111`
    *   取反: `1010 1000`
    *   加1: **`1010 1001`**
*   **c = 53** (正数)
    *   53 = 32+16+4+1 -> **`0011 0101`**

### (c) Boolean Expression Simplification (6 marks)
**原则**: X + NOT(X) = 1, X AND NOT(X) = 0, A + AB = A。需要注意题目中的上划线代表 NOT。

**(i) B(BD + NOT(A AND D)) + NOT(DA)**
1.  展开第一项: BBD + B(NOT(AD)) + NOT(DA)
2.  简化 BB=B: BD + B(NOT(AD)) + NOT(AD)
3.  提取 NOT(AD) (使用 "X + XY = X" 的变体 "CommonTerm + X AND Something"):
    *   观察: B(NOT(AD)) + NOT(AD) = NOT(AD)(B+1) = NOT(AD)
4.  剩下: BD + NOT(AD)
5.  德摩根展开 NOT(AD): BD + NOT(A) + NOT(D)
6.  重组: NOT(A) + (NOT(D) + D B) = NOT(A) + NOT(D) + B
    *   (利用 NOT(X) + XY = NOT(X) + Y)
7.  Result: **NOT(A) + NOT(D) + B**

**(ii) (AB + NOT(A)C)A + NOT(C)C**
1.  NOT(C)C = 0: 第一步消掉尾巴。
2.  展开: ABA + NOT(A)CA
3.  AA=A, NOT(A)A=0: AB + 0
4.  Result: **AB**

**(iii) B(AC + A(AC)) + B NOT(B)**
1.  B NOT(B) = 0: 消掉尾巴。
2.  括号内 A(AC) = AAC = AC。
3.  变成: B(AC + AC) = B(AC) (因为 X+X=X)。
4.  Result: **ABC**

### (d) Truth Table (8 marks)
*(题目未提供 Composite Gate 的图片，无法给出具体答案。通常是给出一个由 NAND/AND/OR 组成的图，需要填 A, B 输入对应的 Output)*
*   **复习建议**: 复习 AND, OR, NOT, NAND, XOR 的真值表，按层级推导即可。

### (e) List 5 Combinational Chips (5 marks)
**考点**: Nand2Tetris 课程中的基础芯片。
1.  **Half Adder**: Adds 2 bits, outputs sum and carry.
2.  **Full Adder**: Adds 3 bits (2 inputs + carry in), outputs sum and carry.
3.  **Mux (Multiplexer)**: Selects between two inputs based on a selector bit.
4.  **DMux (Demultiplexer)**: Channels one input to one of two outputs based on a selector bit.
5.  **ALU (Arithmetic Logic Unit)**: Performs arithmetic and logical operations on two 16-bit inputs.
    *(备选: Inc16, Add16, And16, Not16 等)*

---

## Question 2: Architecture & VM (25 Marks)

**考察重点**: 汇编追踪、伪代码编写、机器码翻译、VM 堆栈操作详解。

### (a) Assembly Code Analysis
**代码逻辑分析**:
*   初始化: R2=0, R3=0。
*   LOOP:
    *   D = R0
    *   D = R0 - R1
    *   如果 D < 0 (即 R0 < R1)，跳转到 IF_STATEMENT。
    *   (否则 R0 >= R1): R0 = R0 - R1 (做减法), R2 = R2 + 1 (计数加1)。
    *   无条件跳回 LOOP。
*   IF_STATEMENT:
    *   检查剩余的 R0 是否为 0。
    *   如果不为 0 (还有余数)，跳到 END。
    *   如果为 0 (整除)，R3 = 1。
*   **总结**: 这是一个**除法程序 (Division)**。
    *   计算 R0 / R1。
    *   **R2** 存储**商 (Quotient)**。
    *   **R0** 最终存储**余数 (Remainder)**。
    *   **R3** 是一个标志位：**R3=1 表示整除 (No remainder)**，R3=0 表示有余数。

**(i) Trace Execution (M[0]=2, M[1]=1)**
*   Round 1:
    *   2 - 1 = 1 (D >= 0, condition JLT fails)
    *   M[0] = 2 - 1 = 1
    *   M[2] = 0 + 1 = 1
*   Round 2:
    *   1 - 1 = 0 (D >= 0, condition JLT fails)
    *   M[0] = 1 - 1 = 0
    *   M[2] = 1 + 1 = 2
*   Round 3:
    *   0 - 1 = -1 (D < 0, condition JLT **True** -> Jump to IF_STATEMENT)
*   IF_STATEMENT:
    *   当前 R0 (M[0]) 为 0。
    *   `D; JNE` (0 != 0 is False)，不跳。
    *   M[3] = 1。
*   **Result**: **M[2] = 2**, **M[3] = 1**.

**(ii) Equivalent High-level Pseudocode (4 marks)**
```python
// Integer Division: R0 / R1
remainder = R0  // In assembly R0 is modified directly
R2 = 0          // Quotient
R3 = 0          // Exact division flag

while (remainder >= R1) {
    remainder = remainder - R1;
    R2 = R2 + 1;
}

if (remainder == 0) {
    R3 = 1;
}
```

**(iii) Machine Code Translation (2 marks)**
1.  **`@END`**: 假设 END 是代码末尾的行号。如果是符号翻译，通常需要题目给出具体行号。*既然是 convert，通常假设 END 是某个具体地址，比如 16 或代码行数。*
    *   *注：如果没有具体行数，通常写出 A-instruction 格式即可。* 假设 END 是第 18 行 (从0开始数指令数)，则是 `@18` -> `0000 0000 0001 0010`。
2.  **`0; JMP`**:
    *   `dest=0` (000), `comp=0` (0101010), `jump=JMP` (111).
    *   Binary: **`1110 1010 1000 0111`**

### (b) VM Final Stack Status (7 marks)
**解析**:
逻辑运算：
*   15==15 (True/-1)
*   10==11 (False/0)
*   92<91 (False/0)
*   91<92 (True/-1)
*   66>67 (False/0)
*   66>66 (False/0)
*   Stack: `[-1, 0, 0, -1, 0, 0]`

算术运算：
*   Stack: `[..., 0, 57]`
*   Push 31, Push 53, Add -> 84. Stack: `[..., 57, 84]`
*   Push 112, Sub (84-112) -> -28.
*   Neg (-28) -> 28.
*   Stack: `[..., 57, 28]`

位运算：
*   And (57 & 28): `00111001 & 00011100` = `00011000` (**24**)
*   Push 8
*   Or (24 | 8): `00011000 | 00001000` = `00011000` (**24**)
*   Not (24): 按位取反 `...11100111` = **-25**

**Final Stack**: `[-1, 0, 0, -1, 0, 0, -25]`

### (c) Stack Operations Diagram for `d = (2 – x) * (y + 5)` (4 marks)
*(这是上一题的重复，也是最经典的题目)*
*   步骤:
    1.  Push 2
    2.  Push x
    3.  Sub -> 生成 `2-x`
    4.  Push y
    5.  Push 5
    6.  Add -> 生成 `y+5`
    7.  Call Math.multiply 2 -> 生成结果
    8.  Pop d -> 栈空。

### (d) Translate VM to Assembly (6 marks)
**题目**: `push constant 1`, `add`
**(这是最基础的送分题，必须拿满分)**

**1. `push constant 1`**
```asm
@1
D=A     // D = 1
@SP
A=M     // A points to Stack Top
M=D     // *SP = 1
@SP
M=M+1   // SP++
```

**2. `add`**
```asm
@SP
AM=M-1  // SP--, A points to Top (y)
D=M     // D = y
A=A-1   // A points to x
M=M+D   // x = x + y
```
