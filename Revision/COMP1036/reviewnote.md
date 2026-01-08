# COMP1036 Computer Fundamentals Revision Note

> 基于 Week 11 Revision Slides 重构，并标注了往年真题考点 (23/24, 24/25)。

## 考试概况 (General Information)
*   **占比**: 总成绩的 50%
*   **时长**: 1 小时
*   **题量**: 2 道大题 (Part 1 & Part 2)

---

## Part 1: Logic & Hardware (Question 1 - 25%)

### 1. 布尔逻辑 (Boolean Logic)
*   **基本门**: AND, OR, NOT。
*   **通用性 (Canonical Representation)**: 所有芯片都可以仅由 **NAND** 门构建。 **[24/25 Q1e]**
*   **优先级 (Precedence)**:
    1.  括号 `()`
    2.  `Not`
    3.  `And`
    4.  `Or`

### ★ 布尔代数速记表 (Boolean Algebra Cheat Sheet)
这些是**最底层**的公理和定律，所有复杂的化简都能用它们推导出来。(注：`'` 表示 NOT，`·` 表示 AND，`+` 表示 OR)

| 类别 | 逻辑乘 (AND) | 逻辑加 (OR) | 记忆技巧 |
| :--- | :--- | :--- | :--- |
| **0/1 律** (Identity/Null) | `X · 1 = X` <br> `X · 0 = 0` | `X + 0 = X` <br> `X + 1 = 1` | 0是乘法黑洞，1是加法黑洞 |
| **幂等律** (Idempotence) | `X · X = X` | `X + X = X` | 自己跟自己玩，还是自己 |
| **互补律** (Inverse) | `X · X' = 0` | `X + X' = 1` | 矛盾必死(0)，互补必生(1) |
| **对合律** (Double Neg) | `(X')' = X` | - | 负负得正 |
| **结合/交换** | `(XY)Z = X(YZ)` <br> `XY = YX` | `(X+Y)+Z = X+(Y+Z)` <br> `X+Y = Y+X` | 顺序不像减法那样重要 |
| **❤️ 分配律** (Distributive) | `X(Y+Z) = XY + XZ` | **`X + YZ = (X+Y)(X+Z)`** | **难点**: 加法居然也能分配进乘法里! |
| **❤️ 德摩根** (De Morgan) | `(XY)' = X' + Y'` | `(X+Y)' = X' · Y'` | **必考**: 断开横线，变符号 |
| **🔥🔥 消除律** (Common Id) | `X(X'+Y) = XY` | **`X + X'Y = X + Y`** | **终极必考**: 遇到复杂的互补项，直接消掉反的那个！<br>例如: `B' + B(AC) = B' + AC` |

> **💡 高级推导 (衍生技巧)**
> *   **吸收 (Absorption)**: `X + XY = X` (既然有了X，多出来的XY纯属多余)
> *   **消除 (Simplification)**: `X + X'Y = X + Y` (既然还要看Y，那X肯定不是1，那X'肯定就是1，划掉)

*   **简化表达式 (Simplification)**: **[23/24 Q1c] [24/25 Q1c]**
    *   **核心定律与例题 (Key Laws & Examples)**:
        *   **吸收律 (Absorption)**: `A(A+B) = A`, `A + AB = A`.
            *   *例题*: 化简 `A + B'AD + AC` -> `A`
        *   **冗余律 (Redundancy/Identities)**: `A + A'B = A + B`.
            *   *例题*: 化简 `A' + A B' C` -> `A' + B'C`
        *   **德摩根定律 (De Morgan's)**:
            *   `Not(x Or y) = Not(x) And Not(y)`
            *   `Not(x And y) = Not(x) Or Not(y)`
            *   *例题*: 化简 `NOT( A (B' + C) )` -> `A' + B C'`
        *   **分配律 (Distributive)**: `A + BC = (A+B)(A+C)` (注意此特殊形式).
            *   *例题*: 化简 `(A + B)(A + B')` -> `A`
        *   **其他基础**:
            *   `X + X = X` (幂等), `X + 1 = 1`, `X * 0 = 0`, `X + X' = 1`.
*   **真值表 (Truth Table)**: **[24/25 Q1d]**
    *   能够列出组合逻辑电路的真值表。

### 2. 布尔算术 (Boolean Arithmetic)
*   **二进制转换**:
    *   Bin -> Dec (Unsigned/Signed): **[23/24 Q1a] [24/25 Q1a]**
    *   Dec -> Bin (Unsigned/Signed): **[23/24 Q1b] [24/25 Q1b]**
*   **有符号数表示 (Representing Negative Numbers)**:
    *   **Sign and Magnitude**: 最高位符号，其余数值 (存在+0, -0)。
    *   **1's Complement (反码)**: 负数为正数按位取反 (存在+0, -0)。
    *   **2's Complement (补码 - 重点)**: **[23/24 Q1a,b] [24/25 Q1a,b]**
        *   **定义**: `-x` 表示为 `2^N - x`。
        *   **计算方法 (Negation)**: **取反加 1** (`NOT(x) + 1`)。
        *   **范围**: `-(2^(N-1))` 到 `2^(N-1) - 1` (例如 8-bit: -128 到 127)。
        *   **特点**: 只有唯一的 0 (`00000000`)。

### 3. 基础芯片 (Combinational Chips) **[24/25 Q1e]**
*   **Half Adder (半加器)**:
    *   输入: a, b
    *   输出: sum (a XOR b), carry (a AND b)
*   **Full Adder (全加器)**:
    *   输入: a, b, c_in
    *   输出: sum, carry (由2个 Half Adder 组成)
*   **Mux (选择器)**: `if (sel==0) out=a else out=b`
*   **DMux**: `if (sel==0) {a=in, b=0} else {a=0, b=in}`
*   **ALU**: 算术逻辑单元。
*   **加法器详解 (Adders)**:
    *   **Half Adder (半加器)**: 算 `a+b`。没有进位输入。
        *   `Sum = a XOR b` (异或: 不同为1)
        *   `Carry = a AND b` (与: 全1才进位)
    *   **Full Adder (全加器)**: 算 `a+b+c`。能处理进位。
        *   由 **2个 Half Adder + 1个 OR** 组成。

### 4. 时序逻辑 (Sequential Logic)
*   **基本概念**:
    *   **DFF (Data Flip Flop)**: 只有在时钟上升沿 (Tick-Tock) 才会吃进新数据，否则一直保持旧数据。 `Out(t) = In(t-1)`。
    *   **Clock (时钟)**: 也就是那个“哨子”。上升沿 (Rising Edge) 是数据更新的瞬间。
*   **Register (寄存器)**: **[23/24 Q1d]**
    *   **本质**: "带开关的 DFF"。
    *   **Load**:
        *   `load=1`: 吃新数据 (Update)。
        *   `load=0`: 吃自己吐出来的旧数据 (Keep)。
    *   **结构**: `Mux(DataOut, DataIn, load) -> DFF` (反馈回路)。
*   **PC (Program Counter)**: **[23/24 Q1e]**
    *   **作用**: 存当前执行到哪行代码了 (下一条指令的地址)。
    *   **三种模式优先级**: **Reset > Load > Inc**。
        *   `Reset`: 归零 (重启)。
        *   `Load`: 跳转 (Jump)。当跳转条件满足时，PC = A寄存器。
        *   `Inc`: PC++ (顺序执行)。

---

## Part 2: Architecture & VM (Question 2 - 25%)

### 1. Hack 汇编 (Hack Assembly) **[23/24 Q2a] [24/25 Q2a]**
*   **A-Instruction (`@value`)**:
    *   **语法**: `@100` 或 `@LOOP`。
    *   **机器码**: `0vvv...v` (最高位是 **0**)。
    *   **作用**: 将 `value` (或标签对应的行号) 存入 **A 寄存器**。
    *   *注*: `@END` 这种标签，在汇编器第二次扫描时会被替换成具体的行号(例如 `@18`)，然后转成 `000...10010`。
*   **C-Instruction (`dest=comp;jump`)**:
    *   **机器码**: `111...` (最高位是 **1**)。
    *   **comp**: 计算什么 (D+A, D-1 等)。
    *   **dest**: 存哪里 (D, M, A)。
    *   **jump**: 怎么跳 (JGT, JEQ)。如果条件满足，**PC 就会 Load 那个跳的地址**。

### 1. Hack 汇编语言 (Hack Assembly)
*   **代码追踪 (Trace)**: **[23/24 Q2a] [24/25 Q2a]**
    *   能够阅读汇编代码，手动执行并给出寄存器状态。
*   **机器码转换 (Machine Code)**: **[23/24 Q2aii] [24/25 Q2aiii]**
    *   **A-Instruction**: `@value` -> `0vvv vvvv vvvv vvvv`
    *   **C-Instruction**: `dest = comp ; jump` -> `111 a cccccc ddd jjj`
*   **寻址模式 (Addressing Modes)**: **[23/24 Q2b]**
    *   **Register**: 操作寄存器 (e.g. `D=A`).
    *   **Direct**: 直接访问内存地址 (e.g. `@100`, `M=D`).
    *   **Indirect**: 通过指针访问 (e.g. `@ptr`, `A=M`, `M=D`).
    *   **Immediate**: 操作常数 (e.g. `@5`, `D=A`).
*   **伪代码 (Pseudocode)**: **[24/25 Q2aii]**
    *   将汇编写回高级语言逻辑 (if/while)。
*   **常见算法模板 (Common Algorithms)**:
    *   **乘法 (Multiplication)**: `R2 = R0 * R1` (通过循环加法实现)
        ```asm
        // 初始化 product (R2) = 0
        @R2
        M=0
        
        // 检查乘数 (R1) 是否为 0, 若为 0 直接结束
        @R1
        D=M
        @END
        D;JEQ

        (LOOP)
           // R2 = R2 + R0
           @R0
           D=M
           @R2
           M=D+M
           
           // R1 = R1 - 1
           @R1
           M=M-1
           D=M
           
           // 如果 R1 > 0, 继续循环
           @LOOP
           D;JGT
        (END)
           @END
           0;JMP
        ```

### 2. 虚拟机 (Virtual Machine)
*   **堆栈模拟 (Stack Trace)**: **[23/24 Q2c] [24/25 Q2b]**
    *   能够按顺序执行 push/pop/add/eq 等指令，画出堆栈状态。
    *   注意 `True = -1` (All 1s), `False = 0`.
*   **表达式转换**: **[23/24 Q2d]**
    *   将中缀表达式 `(a-x) + (y+9)` 转为 VM 代码 (后缀)。
*   **状态图 (State Diagram)**: **[23/24 Q2e] [24/25 Q2c]**
    *   画出 SP 指针移动和堆栈内容变化。
*   **常见算法 (Common Algorithms)**:
    *   **乘法 (Multiplication)**: `mult.vm` (循环加法)
        ```vm
        // Argument 0 = x, Argument 1 = y
        // Local 0 = sum (积)
        
        function Mult 1      // 声明函数，1个局部变量
        push constant 0
        pop local 0          // sum = 0
        
        label LOOP
        push argument 1      // y (剩余乘法次数)
        push constant 0
        eq
        if-goto END          // if y == 0, 结束
        
        push local 0         // sum
        push argument 0      // x
        add
        pop local 0          // sum = sum + x
        
        push argument 1      // y
        push constant 1
        sub                  // y = y - 1
        pop argument 1
        
        goto LOOP
        
        label END
        push local 0         // 压入结果
        return
        ```

### 3. VM 实现与翻译 (VM Implementation) **[23/24 Q2f] [24/25 Q2d]**
**必考题**: 将 VM 指令翻译为 Hack 汇编。

#### A. `push constant i`
*   **逻辑**: `*SP = i`, `SP++`
*   **Hack Assembly**:
    ```asm
    @i
    D=A      // D = i
    @SP
    A=M      // A = SP
    M=D      // *SP = D
    @SP
    M=M+1    // SP++
    ```

#### B. `add`
*   **逻辑**: Pop y, Pop x, Push (x+y)
*   **Hack Assembly**:
    ```asm
    @SP
    AM=M-1   // SP--, A=SP
    D=M      // D = y
    A=A-1    // A = SP-1 (point to x)
    M=M+D    // x = x + y
    ```

#### C. `push local i`
*   **逻辑**: `addr = LCL + i`, `*SP = *addr`, `SP++`
*   **Hack Assembly**:
    ```asm
    @i
    D=A
    @LCL
    A=D+M     // A = LCL + i
    D=M       // D = RAM[LCL+i]
    @SP
    A=M
    M=D       // *SP = D
    @SP
    M=M+1     // SP++
    ```

#### D. `pop local i`
*   **逻辑**: `addr = LCL + i`, `SP--`, `*addr = *SP`
*   **Hack Assembly**:
    ```asm
    @i
    D=A
    @LCL
    D=D+M
    @addr     // 临时存地址
    M=D
    @SP
    AM=M-1    // SP--
    D=M       // D = *SP
    @addr
    A=M
    M=D       // *addr = D
    ```

### 4. 内存结构与架构 (Memory & Architecture)
*   **Fetch-Execute Cycle**: Fetch (从 ROM 取指令) -> Decode (解析指令) -> Execute (ALU/Jump/Memory)。
*   **I/O**:
    *   Screen: RAM[16384]
    *   Keyboard: RAM[24576]

