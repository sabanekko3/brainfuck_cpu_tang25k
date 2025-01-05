//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9 (64-bit)
//Part Number: GW5A-LV25MG121NES
//Device: GW5A-25
//Device Version: A
//Created Time: Fri Jan  3 12:40:58 2025

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    Gowin_SP your_instance_name(
        .dout(dout_o), //output [7:0] dout
        .clk(clk_i), //input clk
        .oce(oce_i), //input oce
        .ce(ce_i), //input ce
        .reset(reset_i), //input reset
        .wre(wre_i), //input wre
        .ad(ad_i), //input [7:0] ad
        .din(din_i) //input [7:0] din
    );

//--------Copy end-------------------
