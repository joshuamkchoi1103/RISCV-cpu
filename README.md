# 🧠 JOSHFLOAT CPU – Custom 9-bit RISC Processor

**Author**: Joshua Choi  
**Course**: UCSD CSE 141L – Computer Architecture Lab  

## 🔍 Overview

JOSHFLOAT is a fully custom 9-bit RISC-style CPU designed to support floating-point program execution within strict instruction size constraints. Built as part of the UCSD CSE 141L final project, this architecture balances compact encoding with powerful operations. The processor uses a register-register and load-store design philosophy, optimized to execute three floating-point programs using a minimal yet expressive instruction set.

## 🧱 Architecture Highlights

- **Instruction Width**: 9 bits  
- **Design Style**: RISC, Register-Register / Load-Store  
- **ALU Support**: Arithmetic, Bitwise, Logical, and Shift operations  
- **Branching**: Compact conditional branching using `beq` and `bne`  
- **Memory**: Direct addressing via immediates, 8-bit data width  
- **Registers**: 4 general-purpose registers (R0–R3)

## 🧮 Instruction Set Architecture (ISA)

| Type | Format                 | Instructions                           |
|------|------------------------|----------------------------------------|
| R    | 3b opcode, 2b rs, 2b rt, 2b func | `add`, `sub`, `not`, `lsb`, `msb`, `slt`, `shl`, `shr` |
| I    | 3b opcode, 2b reg, 4b imm        | `lw`, `sw`, `mov`                      |
| B    | 3b opcode, 2b rs, 2b rt, 2b offset | `beq`, `bne` (uses R1 and R2 only)     |
| D    | 3b opcode, 6b unused             | `done`                                 |

✅ Notable instructions:
- `mov R1, #13` – move immediate to register  
- `slt R0, R1, R2` – set if less than  
- `done` – raises a done flag for program termination

## ⚙️ Components

- **Top Level Module**: `Top_level.sv`
  - Connects all components and controls the data path
  - Handles program counter updates, memory interface, and control signals
- **ALU Module**: `ALU_0.sv`
  - Performs all arithmetic, logic, and branching operations
- **Memory**: 8-bit wide RAM
  - Separate register file and data memory blocks
- **PC (Program Counter)**: 10-bit, handles conditional branching via signed offset logic

## 💻 Programming Model

- Use `mov`, `lw`, `sw` for value manipulation  
- Use `slt`, `beq`, `bne` for control flow  
- All data interactions are done through registers and memory  
- Branching uses PC-relative 2's complement offsets with fixed R1 and R2 comparison

## 🧪 Testbench / Simulation

- Simulated using a SystemVerilog testbench
- Programs loaded via memory initialization
- `done` flag signals termination


## 📌 Features

- Custom compact instruction encoding with 3-bit opcodes
- Hardware branch control without LUTs
- Includes both arithmetic and logic instructions with minimal hardware overhead



