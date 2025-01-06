module ROM (
    input [10:0] addr,
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
`define NOP  3'b000 //,

localparam len = 65;

always_comb begin
    case(addr)
        10'h000:code <= `INC;
        10'h001:code <= `INC;
        10'h002:code <= `INC;
        10'h003:code <= `INC;
        10'h004:code <= `INC;
        10'h005:code <= `INC;
        10'h006:code <= `INC;
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
        10'h013:code <= `INC;
        10'h014:code <= `INC;
        10'h015:code <= `OUT;
        10'h016:code <= `MOVR;
        10'h017:code <= `MOVR;
        10'h018:code <= `INC;
        10'h019:code <= `IF;
        10'h01a:code <= `MOVR;
        10'h01b:code <= `INC;
        10'h01c:code <= `INC;
        10'h01d:code <= `INC;
        10'h01e:code <= `INC;
        10'h01f:code <= `INC;
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
        10'h02b:code <= `INC;
        10'h02c:code <= `INC;
        10'h02d:code <= `INC;
        10'h02e:code <= `INC;
        10'h02f:code <= `INC;
        10'h030:code <= `IF;
        10'h031:code <= `MOVL;
        10'h032:code <= `MOVL;
        10'h033:code <= `INC;
        10'h034:code <= `OUT;
        10'h035:code <= `MOVR;
        10'h036:code <= `MOVR;
        10'h037:code <= `DEC;
        10'h038:code <= `BACK;
        10'h039:code <= `MOVL;
        10'h03a:code <= `MOVL;
        10'h03b:code <= `IF;
        10'h03c:code <= `DEC;
        10'h03d:code <= `OUT;
        10'h03e:code <= `BACK;
        10'h03f:code <= `MOVR;
        10'h040:code <= `BACK;
        default:code <=  `INC;
    endcase
end

assign rom_overrun =  addr < len ? 1'h0 : 1'h1;

endmodule
