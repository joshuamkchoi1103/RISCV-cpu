REGISTER_MAP = {
    'R0': '00',
    'R1': '01',
    'R2': '10',
    'R3': '11',
}

OPCODES = {
    'add':  '000',
    'sub':  '000',
    'not':  '000',
    'lsb':  '000',  # formerly 'or'
    'msb':  '001',
    'slt':  '001',
    'shl':  '001',
    'shr':  '001',
    'mov':  '010',
    'lw':   '011',
    'sw':   '100',
    'beq':  '101',
    'bne':  '110',
    'done': '111'
}

FUNCT_CODES = {
    'add': '00',
    'sub': '01',
    'not': '10',
    'lsb': '11',  # formerly 'or'
    'msb': '00',
    'slt': '01',
    'shl': '10',
    'shr': '11',
}

def to_bin(value, bits):
    """Convert integer to 2's complement binary string of width `bits`."""
    if value < 0:
        value = (1 << bits) + value
    return format(value, f'0{bits}b')[-bits:]

def assemble_line(line):
    line = line.split('//')[0].strip()
    if not line:
        return ''
    
    parts = line.replace(',', '').split()
    instr = parts[0]
    
    if instr not in OPCODES:
        raise ValueError(f"Unknown instruction: {instr}")
    
    opcode = OPCODES[instr]

    # R-type instructions (ALU)
    if instr in FUNCT_CODES:
        funct = FUNCT_CODES[instr]
        if instr in ['shl', 'shr']:
            if len(parts) != 2:
                raise ValueError(f"{instr} requires one register: {line}")
            rs = REGISTER_MAP[parts[1]]
            rt = '00'
        elif instr in ['msb', 'not', 'lsb']:
            if len(parts) != 3 or parts[1] != 'R0':
                raise ValueError(f"{instr} must be: {instr} R0, Rs")
            rs = REGISTER_MAP[parts[2]]
            rt = '00'
        else:
            if len(parts) != 4 or parts[1] != 'R0':
                raise ValueError(f"{instr} must be: {instr} R0, Rs, Rt")
            rs = REGISTER_MAP[parts[2]]
            rt = REGISTER_MAP[parts[3]]
        return opcode + rs + rt + funct

    # I-type instructions (mov, lw, sw)
    elif instr in ['mov', 'lw', 'sw']:
        if len(parts) != 3 or not parts[2].startswith('#'):
            raise ValueError(f"{instr} must be: {instr} Rn, #imm")
        reg = REGISTER_MAP[parts[1]]
        imm = int(parts[2][1:])
        if not (0 <= imm < 16):
            raise ValueError(f"Immediate for {instr} must be in [0,15]: got {imm}")
        imm_bin = to_bin(imm, 4)
        return opcode + reg + imm_bin

    # B-type instructions (beq, bne)
    elif instr in ['beq', 'bne']:
        if len(parts) != 4 or parts[1] != 'R1' or parts[2] != 'R2' or not parts[3].startswith('#'):
            raise ValueError(f"{instr} must be: {instr} R1, R2, #offset")
        offset = int(parts[3][1:])
        if not (-32 <= offset <= 31):
            raise ValueError(f"Offset for {instr} must be in [-32,31]: got {offset}")
        return opcode + to_bin(offset, 6)

    # D-type: done
    elif instr == 'done':
        return opcode + '000000'

    else:
        raise ValueError(f"Instruction not supported: {instr}")

def assemble_file(input_file, output_file):
    with open(input_file, 'r') as asm, open(output_file, 'w') as out:
        for lineno, line in enumerate(asm, start=1):
            try:
                binary = assemble_line(line)
                if binary:
                    if len(binary) != 9:
                        raise ValueError(f"Instruction not 9 bits: {binary}")
                    out.write(binary + '\n')
            except ValueError as e:
                print(f"[ERROR line {lineno}] {e}")

if __name__ == "__main__":
    assemble_file("assembly.txt", "machine_code.txt")
