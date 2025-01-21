
interface PWMPair;
wire h,l;

modport outcome(
    output h,l
);
modport entry(
    input h,l
);

endinterface 