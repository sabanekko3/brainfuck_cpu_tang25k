def decode_bf_cmd(cmd):
    if(c == '+'):
        return "`INC"
    elif(c == '-'):
        return "`DEC"
    elif(c == '>'):
        return "`MOVR"
    elif(c == '<'):
        return "`MOVL"
    elif(c == '['):
        return "`IF"
    elif(c == ']'):
        return "`BACK"
    elif(c == '.'):
        return "`OUT"
    elif(c == ','):
        return "`IN"
    else:
        return None

with open("src.bf", "r") as bf_code, open("../src/rom.sv", "w") as bfrom:
    bfrom.write("module ROM (\n")
    bfrom.write("    input [7:0] addr,\n")
    bfrom.write("    output reg [2:0] code,\n")
    bfrom.write("    output rom_overrun\n")
    bfrom.write(");\n")
    bfrom.write("`define INC  3'b111 //+\n")
    bfrom.write("`define DEC  3'b110 //-\n")
    bfrom.write("`define MOVR 3'b101 //>\n")
    bfrom.write("`define MOVL 3'b100 //<\n")
    bfrom.write("`define IF   3'b011 //[\n")
    bfrom.write("`define BACK 3'b010 //]\n")
    bfrom.write("`define OUT  3'b001 //.\n")
    bfrom.write("`define NOP  3'b000 //,\n\n")
    

    code = []
    while True:
        char = bf_code.read(1) # 一文字ずつ読み取る

        if not char: # ファイルの終わりに達したらループを終了
            break
        elif(char == '+' or char == '-' or char == '>' or char == '<'\
            or char == '[' or char == ']' or char == '.' or char == ','):
            code += [char]
    bfrom.write(f"localparam len = {len(code)};\n\n ")
    bfrom.write(f"wire [2:0] rom_array[0:len-1] = '{{\n")
    
    for c in code[:-1]:
        bfrom.write("    " + decode_bf_cmd(c) + ",\n")

    bfrom.write("    " + decode_bf_cmd(code[-1]) + "\n")
    
    bfrom.write("};\n\n")

    bfrom.write(f"assign code = addr < len ? rom_array[addr] : 3'h0;\n")
    bfrom.write(f"assign rom_overrun =  addr < len ? 1'h0 : 1'h1;\n\n")

    bfrom.write("endmodule\n")