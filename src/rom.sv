//decoded from pi_control.bf

module ROM (
    input [9:0] addr,
    output reg [2:0] code,
    output rom_overrun
);
`define INC  3'b111 //+
`define DEC  3'b110 //-
`define MOVR 3'b101 //>
`define MOVL 3'b100 //<
`define IF   3'b011 //[
`define BACK 3'b010 //]
`define OUT  3'b001 //.
`define IN  3'b000 //,

localparam len = 147;

always_comb begin
    case(addr)
        10'h000:code <= `INC;
        10'h001:code <= `INC;
        10'h002:code <= `INC;
        10'h003:code <= `INC;
        10'h004:code <= `INC;
        10'h005:code <= `IF;
        10'h006:code <= `MOVR;
        10'h007:code <= `INC;
        10'h008:code <= `INC;
        10'h009:code <= `INC;
        10'h00a:code <= `INC;
        10'h00b:code <= `INC;
        10'h00c:code <= `INC;
        10'h00d:code <= `INC;
        10'h00e:code <= `INC;
        10'h00f:code <= `INC;
        10'h010:code <= `INC;
        10'h011:code <= `INC;
        10'h012:code <= `INC;
        10'h013:code <= `MOVL;
        10'h014:code <= `DEC;
        10'h015:code <= `BACK;
        10'h016:code <= `MOVR;
        10'h017:code <= `OUT;
        10'h018:code <= `MOVR;
        10'h019:code <= `MOVR;
        10'h01a:code <= `MOVR;
        10'h01b:code <= `INC;
        10'h01c:code <= `OUT;
        10'h01d:code <= `MOVR;
        10'h01e:code <= `DEC;
        10'h01f:code <= `OUT;
        10'h020:code <= `INC;
        10'h021:code <= `INC;
        10'h022:code <= `INC;
        10'h023:code <= `INC;
        10'h024:code <= `INC;
        10'h025:code <= `INC;
        10'h026:code <= `INC;
        10'h027:code <= `INC;
        10'h028:code <= `INC;
        10'h029:code <= `INC;
        10'h02a:code <= `INC;
        10'h02b:code <= `IF;
        10'h02c:code <= `MOVR;
        10'h02d:code <= `INC;
        10'h02e:code <= `INC;
        10'h02f:code <= `INC;
        10'h030:code <= `INC;
        10'h031:code <= `INC;
        10'h032:code <= `INC;
        10'h033:code <= `INC;
        10'h034:code <= `INC;
        10'h035:code <= `INC;
        10'h036:code <= `INC;
        10'h037:code <= `INC;
        10'h038:code <= `INC;
        10'h039:code <= `MOVR;
        10'h03a:code <= `INC;
        10'h03b:code <= `INC;
        10'h03c:code <= `INC;
        10'h03d:code <= `INC;
        10'h03e:code <= `INC;
        10'h03f:code <= `INC;
        10'h040:code <= `INC;
        10'h041:code <= `INC;
        10'h042:code <= `INC;
        10'h043:code <= `INC;
        10'h044:code <= `INC;
        10'h045:code <= `INC;
        10'h046:code <= `MOVR;
        10'h047:code <= `MOVR;
        10'h048:code <= `INC;
        10'h049:code <= `INC;
        10'h04a:code <= `INC;
        10'h04b:code <= `INC;
        10'h04c:code <= `INC;
        10'h04d:code <= `MOVL;
        10'h04e:code <= `MOVL;
        10'h04f:code <= `MOVL;
        10'h050:code <= `MOVL;
        10'h051:code <= `DEC;
        10'h052:code <= `BACK;
        10'h053:code <= `MOVR;
        10'h054:code <= `OUT;
        10'h055:code <= `MOVR;
        10'h056:code <= `OUT;
        10'h057:code <= `MOVR;
        10'h058:code <= `MOVR;
        10'h059:code <= `OUT;
        10'h05a:code <= `MOVL;
        10'h05b:code <= `MOVL;
        10'h05c:code <= `MOVL;
        10'h05d:code <= `IF;
        10'h05e:code <= `MOVL;
        10'h05f:code <= `MOVL;
        10'h060:code <= `MOVL;
        10'h061:code <= `MOVL;
        10'h062:code <= `IN;
        10'h063:code <= `IF;
        10'h064:code <= `IN;
        10'h065:code <= `BACK;
        10'h066:code <= `MOVR;
        10'h067:code <= `MOVR;
        10'h068:code <= `MOVR;
        10'h069:code <= `MOVR;
        10'h06a:code <= `MOVR;
        10'h06b:code <= `MOVR;
        10'h06c:code <= `MOVR;
        10'h06d:code <= `MOVR;
        10'h06e:code <= `IN;
        10'h06f:code <= `IF;
        10'h070:code <= `DEC;
        10'h071:code <= `MOVL;
        10'h072:code <= `MOVL;
        10'h073:code <= `INC;
        10'h074:code <= `MOVL;
        10'h075:code <= `INC;
        10'h076:code <= `INC;
        10'h077:code <= `INC;
        10'h078:code <= `INC;
        10'h079:code <= `INC;
        10'h07a:code <= `INC;
        10'h07b:code <= `INC;
        10'h07c:code <= `MOVR;
        10'h07d:code <= `MOVR;
        10'h07e:code <= `MOVR;
        10'h07f:code <= `BACK;
        10'h080:code <= `MOVL;
        10'h081:code <= `MOVL;
        10'h082:code <= `MOVL;
        10'h083:code <= `OUT;
        10'h084:code <= `MOVR;
        10'h085:code <= `IF;
        10'h086:code <= `DEC;
        10'h087:code <= `MOVL;
        10'h088:code <= `DEC;
        10'h089:code <= `DEC;
        10'h08a:code <= `DEC;
        10'h08b:code <= `DEC;
        10'h08c:code <= `DEC;
        10'h08d:code <= `DEC;
        10'h08e:code <= `MOVR;
        10'h08f:code <= `BACK;
        10'h090:code <= `MOVL;
        10'h091:code <= `MOVL;
        10'h092:code <= `BACK;
        default:code <=  `INC;
    endcase
end

assign rom_overrun =  addr < len ? 1'h0 : 1'h1;

endmodule
