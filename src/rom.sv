//decoded from speed_p_control.bf

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

localparam len = 102;

always_comb begin
    case(addr)
        10'h000:code <= `MOVR;
        10'h001:code <= `MOVR;
        10'h002:code <= `MOVR;
        10'h003:code <= `INC;
        10'h004:code <= `OUT;
        10'h005:code <= `MOVR;
        10'h006:code <= `DEC;
        10'h007:code <= `OUT;
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
        10'h013:code <= `IF;
        10'h014:code <= `MOVR;
        10'h015:code <= `INC;
        10'h016:code <= `INC;
        10'h017:code <= `INC;
        10'h018:code <= `INC;
        10'h019:code <= `INC;
        10'h01a:code <= `INC;
        10'h01b:code <= `INC;
        10'h01c:code <= `INC;
        10'h01d:code <= `INC;
        10'h01e:code <= `INC;
        10'h01f:code <= `INC;
        10'h020:code <= `INC;
        10'h021:code <= `MOVR;
        10'h022:code <= `INC;
        10'h023:code <= `INC;
        10'h024:code <= `INC;
        10'h025:code <= `INC;
        10'h026:code <= `INC;
        10'h027:code <= `INC;
        10'h028:code <= `INC;
        10'h029:code <= `INC;
        10'h02a:code <= `INC;
        10'h02b:code <= `INC;
        10'h02c:code <= `INC;
        10'h02d:code <= `INC;
        10'h02e:code <= `MOVL;
        10'h02f:code <= `MOVL;
        10'h030:code <= `DEC;
        10'h031:code <= `BACK;
        10'h032:code <= `MOVR;
        10'h033:code <= `OUT;
        10'h034:code <= `MOVR;
        10'h035:code <= `OUT;
        10'h036:code <= `MOVL;
        10'h037:code <= `IF;
        10'h038:code <= `MOVR;
        10'h039:code <= `MOVR;
        10'h03a:code <= `MOVR;
        10'h03b:code <= `MOVR;
        10'h03c:code <= `IN;
        10'h03d:code <= `IF;
        10'h03e:code <= `DEC;
        10'h03f:code <= `MOVL;
        10'h040:code <= `MOVL;
        10'h041:code <= `INC;
        10'h042:code <= `MOVL;
        10'h043:code <= `DEC;
        10'h044:code <= `DEC;
        10'h045:code <= `DEC;
        10'h046:code <= `DEC;
        10'h047:code <= `DEC;
        10'h048:code <= `MOVR;
        10'h049:code <= `MOVR;
        10'h04a:code <= `MOVR;
        10'h04b:code <= `BACK;
        10'h04c:code <= `MOVL;
        10'h04d:code <= `MOVL;
        10'h04e:code <= `MOVL;
        10'h04f:code <= `OUT;
        10'h050:code <= `MOVR;
        10'h051:code <= `IF;
        10'h052:code <= `DEC;
        10'h053:code <= `MOVL;
        10'h054:code <= `INC;
        10'h055:code <= `INC;
        10'h056:code <= `INC;
        10'h057:code <= `INC;
        10'h058:code <= `INC;
        10'h059:code <= `MOVR;
        10'h05a:code <= `BACK;
        10'h05b:code <= `MOVR;
        10'h05c:code <= `MOVR;
        10'h05d:code <= `IF;
        10'h05e:code <= `DEC;
        10'h05f:code <= `BACK;
        10'h060:code <= `OUT;
        10'h061:code <= `MOVL;
        10'h062:code <= `MOVL;
        10'h063:code <= `MOVL;
        10'h064:code <= `MOVL;
        10'h065:code <= `BACK;
        default:code <=  `INC;
    endcase
end

assign rom_overrun =  addr < len ? 1'h0 : 1'h1;

endmodule
