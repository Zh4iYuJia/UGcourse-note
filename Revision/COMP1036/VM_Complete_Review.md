# VM 核心复习笔记 (Part 1 & Part 2)

这份笔记涵盖了 Week 09 和 Week 10 的核心内容，从 VM 基础架构到高级的函数调用机制。

---

# Part 1: VM 基础架构与算术运算 (Week 09)

## 1. 为什么要使用虚拟机 (Motivation)

### 两层编译模型 (Two-Tier Compilation)
*   **问题**: N 种高级语言 x M 种硬件平台 = N*M 个编译器。
*   **解决方案**: 引入中间语言 (VM Code)。
    *   N 个前端 (语言 -> VM)
    *   M 个后端 (VM -> 硬件)
*   **Hack 实现**: `.jack` -> `.vm` -> `.asm` -> `.hack`

## 2. VM 架构模型

### 堆栈机器 (Stack Machine)
*   **核心逻辑**: 所有运算的操作数必须先压入栈顶；结果压回栈顶。
*   **数据类型**: 16 位有符号整数。

### 内存访问指令 (Memory Access)

| 内存段 (Segment) | 用途 | 对应 Hack 硬件/实现 |
| :--- | :--- | :--- |
| **constant** | 虚拟段，加载常数 | 直接生成 `@value` |
| **static** | 静态变量 (类级别) | 汇编符号 `@FileName.i` (RAM[16]起) |
| **local** | 局部变量 | 基地址存 `LCL` (RAM[1]) |
| **argument** | 函数参数 | 基地址存 `ARG` (RAM[2]) |
| **this** | 当前对象字段 | 基地址存 `THIS` (RAM[3]) |
| **that** | 数组/堆数据 | 基地址存 `THAT` (RAM[4]) |
| **temp** | 临时变量 | 固定映射 `RAM[5] - RAM[12]` |
| **pointer** | 指针操作 | `0` -> `THIS`, `1` -> `THAT` |

## 3. 算术与逻辑指令 (关键 9 条)

*   **双目**: `add` (+), `sub` (-), `and` (&), `or` (|)
    *   *逻辑: 弹出 y，弹出 x，与 x op y*
*   **单目**: `neg` (-x), `not` (!x)
*   **比较**: `eq`, `gt`, `lt`
    *   *结果: True = -1 (`1111...`), False = 0*

## 4. 汇编翻译实现 (Part 1 考点)

### 标准指针对映
`SP` (RAM[0]), `LCL` (RAM[1]), `ARG` (RAM[2]), `THIS` (RAM[3]), `THAT` (RAM[4])

### 必考翻译模板

#### A. `push constant i`
```asm
@i
D=A     // D = i
@SP
A=M
M=D     // *SP = i
@SP
M=M+1   // SP++
```

#### B. `add`
```asm
@SP
AM=M-1  // SP--, A指向y
D=M     // D = y
A=A-1   // A指向x
M=M+D   // x = x + y (覆盖)
```

#### C. `pop local i` (使用临时变量)
```asm
@i
D=A
@LCL
D=D+M   // 计算目标地址 addr = LCL + i
@R13    // 暂存地址到 R13
M=D
@SP
AM=M-1  // SP--, 取栈顶值
D=M
@R13
A=M     // A = addr
M=D     // *addr = val
```

---

# Part 2: 流程控制与函数调用 (Week 10)

## 5. 流程控制 (Program Flow)

支持高级语言的 `if`, `while` 结构。

*   **`label symbol`**: 声明标签 (函数内有效)。
*   **`goto symbol`**: 无条件跳转。
*   **`if-goto symbol`**: 
    *   **从栈顶弹出一个值**。
    *   如果该值 **!= 0** (True)，则跳转。
    *   否则，继续执行。

## 6. 函数调用机制 (Function Calling)

### 调用协议 (Calling Protocol)

#### A. 定义函数: `function functionName nVars`
*   **入口标签**: 生成 `(functionName)`。
*   **初始化**: 将 `nVars` 个 **0** 压入堆栈 (初始化局部变量)。

#### B. 调用函数: `call functionName nArgs` (Caller 做)
1.  **Push ReturnAddress**: 压入返回地址标号。
2.  **Push LCL, ARG, THIS, THAT**: 保存 Caller 状态。
3.  **重置 ARG**: `ARG = SP - nArgs - 5` (指向第一个参数)。
4.  **重置 LCL**: `LCL = SP` (为 Callee 准备新的 local 段)。
5.  **Goto functionName**: 跳转。
6.  **声明 ReturnAddress 标签**: 供返回使用。

#### C. 返回: `return` (Callee 做)
1.  **FRAME = LCL**: 暂存栈帧基址。
2.  **RET = *(FRAME-5)**: 取出返回地址。
3.  **重置返回值**: `*ARG = pop()` (将结果放到 Caller 栈顶)。
4.  **恢复 SP**: `SP = ARG + 1`。
5.  **恢复状态**: 依次恢复 `THAT`, `THIS`, `ARG`, `LCL`。
6.  **Goto RET**: 跳回 Caller。

---

## 7. 引导程序 (Bootstrap)
VM 初始化的第一步代码 (`Sys.init`):
1.  `SP = 256`
2.  `call Sys.init 0`

## 8. 考试重点总结
1.  **全局堆栈图 (Global Stack)**: 能够画出 `call` 发生后的堆栈结构 (ARG, Saved State, Local)。
2.  **指针偏移计算**: 熟练掌握 `pop local i` 中地址的计算过程 (`LCL + i`)。
3.  **if-goto 逻辑**: 记住它是弹出值并判断是否非零。
4.  **True/False 值**: 尤其注意比较指令生成的是 `-1` 或 `0`。
