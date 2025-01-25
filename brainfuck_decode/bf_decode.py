import os

def list_bf_files():
    bf_files = [f for f in os.listdir() if f.endswith('.bf')]
    return bf_files

def display_and_select_file(bf_files):
    if not bf_files:
        print("No .bf files found in the directory.")
        return None

    for idx, file in enumerate(bf_files):
        print(f"{idx + 1}: {file}")

    choice = int(input("Enter the number of the file you want to decode: ")) - 1
    if 0 <= choice < len(bf_files):
        return bf_files[choice]
    else:
        print("Invalid choice.")
        return None

def decode_bf_cmd(cmd):
    if(cmd == '+'):
        return "`INC"
    elif(cmd == '-'):
        return "`DEC"
    elif(cmd == '>'):
        return "`MOVR"
    elif(cmd == '<'):
        return "`MOVL"
    elif(cmd == '['):
        return "`IF"
    elif(cmd == ']'):
        return "`BACK"
    elif(cmd == '.'):
        return "`OUT"
    elif(cmd == ','):
        return "`IN"
    else:
        return None

file_name = display_and_select_file(list_bf_files())

with open(file_name, "r") as bf_code, open("../src/rom.sv", "w") as bfrom:
    bfrom.write(f"//decoded from {file_name}\n\n")
    bfrom.write("module ROM (\n")
    bfrom.write("    input [9:0] addr,\n")
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
    bfrom.write("`define IN  3'b000 //,\n\n")
    
    
    code = []
    while True:
        char = bf_code.read(1) # 一文字ずつ読み取る

        if not char: # ファイルの終わりに達したらループを終了
            break
        
        if cmd := decode_bf_cmd(char):
            code += [cmd]

    bfrom.write(f"localparam len = {len(code)};\n\n")
    bfrom.write("always_comb begin\n")
    bfrom.write(f"    case(addr)\n")
    
    for i in range(len(code)):
        bfrom.write(f"        10'h{i:03x}:code <= " + code[i] + ";\n")
    
    bfrom.write("        default:code <=  `INC;\n")
    bfrom.write("    endcase\n")
    bfrom.write("end\n\n")

    bfrom.write(f"assign rom_overrun =  addr < len ? 1'h0 : 1'h1;\n\n")

    bfrom.write("endmodule\n")