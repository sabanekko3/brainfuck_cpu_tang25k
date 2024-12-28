module SevSeg(
    input [3:0] data,
    output [6:0] display
);
 
// aaa
//f   b
//f   b
// ggg
//e   c
//e   c
// ddd

wire [3:0]ndata = ~data;

wire a =  ndata[3] & ndata[2] & ndata[1] &  data[0] |
          ndata[3] &  data[2] & ndata[1] & ndata[0] |
           data[3] & ndata[2] &  data[1] &  data[0] |
           data[3] &  data[2] & ndata[1] &  data[0] ;

wire b =  ndata[3] &  data[2] & ndata[1] &  data[0] |
                      data[2] &  data[1] & ndata[0] |
           data[3] &  data[2] &            ndata[0] |
           data[3] &              data[1] &  data[0];

wire c =  ndata[3] & ndata[2] &  data[1] & ndata[0] |
           data[3] &  data[2] &  data[1]            |
           data[3] &  data[2] &            ndata[0] ;

wire d =  ndata[3] & ndata[2] & ndata[1] &  data[0] |
          ndata[3] &  data[2] & ndata[1] & ndata[0] |
                      data[2] &  data[1] &  data[0] |
           data[3] & ndata[2] &  data[1] & ndata[0] ;

wire e =  ndata[3] &                        data[0] |
          ndata[3] &  data[2] & ndata[1]            |
                     ndata[2] & ndata[1] &  data[0] ;

wire f =  ndata[3] & ndata[2] &  data[1]            |
          ndata[3] & ndata[2] &             data[0] |
           data[3] &  data[2] & ndata[1] &  data[0] ;

wire g =  ndata[3] & ndata[2] & ndata[1]            |
          ndata[3] &  data[2] &  data[1] &  data[0] |
           data[3] &  data[2] & ndata[1] & ndata[0] ;

assign display = {~g,~f,~e,~d,~c,~b,~a};

endmodule