/* Verilog netlist generated by SCUBA Diamond (64-bit) 3.12.1.454 */
/* Module Version: 2.8 */
/* D:\fpgaTools\latticeDiamond\diamond\3.12\ispfpga\bin\nt64\scuba.exe -w -n font_rom -lang verilog -synth lse -bus_exp 7 -bb -arch xo2c00 -type rom -addr_width 10 -num_rows 1024 -data_width 8 -outdata UNREGISTERED -memfile d:/fpga_work/md320-256-70e/font_rom.mem -memformat hex  */
/* Thu Aug 15 09:26:21 2024 */


`timescale 1 ns / 1 ps
module font_rom (Address, Q)/* synthesis NGD_DRC_MASK=1 */;
    input wire [9:0] Address;
    output wire [7:0] Q;

    wire mdL0_0_3;
    wire mdL0_0_2;
    wire mdL0_0_1;
    wire mdL0_0_0;
    wire mdL0_1_3;
    wire mdL0_1_2;
    wire mdL0_1_1;
    wire mdL0_1_0;
    wire mdL0_2_3;
    wire mdL0_2_2;
    wire mdL0_2_1;
    wire mdL0_2_0;
    wire mdL0_3_3;
    wire mdL0_3_2;
    wire mdL0_3_1;
    wire mdL0_3_0;
    wire mdL0_4_3;
    wire mdL0_4_2;
    wire mdL0_4_1;
    wire mdL0_4_0;
    wire mdL0_5_3;
    wire mdL0_5_2;
    wire mdL0_5_1;
    wire mdL0_5_0;
    wire mdL0_6_3;
    wire mdL0_6_2;
    wire mdL0_6_1;
    wire mdL0_6_0;
    wire mdL0_7_3;
    wire mdL0_7_2;
    wire mdL0_7_1;
    wire mdL0_7_0;

    defparam mem_0_7.initval = 256'h0000000000000000000000000000000000000000000000000000000000000000 ;
    ROM256X1A mem_0_7 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_0_0));

    defparam mem_0_6.initval = 256'h0000000000000000000000000000000000000000000000000000000000000000 ;
    ROM256X1A mem_0_6 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_1_0));

    defparam mem_0_5.initval = 256'h0000000000000000000000000000000000000000000000000000000000000000 ;
    ROM256X1A mem_0_5 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_2_0));

    defparam mem_0_4.initval = 256'h0000000000000000000000000000000000000000000000000000000000000000 ;
    ROM256X1A mem_0_4 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_3_0));

    defparam mem_0_3.initval = 256'h0000000000000000000000000000000000000000000000000000000000000000 ;
    ROM256X1A mem_0_3 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_4_0));

    defparam mem_0_2.initval = 256'h0000000000000000000000000000000000000000000000000000000000000000 ;
    ROM256X1A mem_0_2 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_5_0));

    defparam mem_0_1.initval = 256'h0000000000000000000000000000000000000000000000000000000000000000 ;
    ROM256X1A mem_0_1 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_6_0));

    defparam mem_0_0.initval = 256'h0000000000000000000000000000000000000000000000000000000000000000 ;
    ROM256X1A mem_0_0 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_7_0));

    defparam mem_1_7.initval = 256'h0000000000000000000000000000000000000000000800000000000000000000 ;
    ROM256X1A mem_1_7 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_0_1));

    defparam mem_1_6.initval = 256'h0000000000000000000000500000003E01000000002A00000048620014000000 ;
    ROM256X1A mem_1_6 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_1_1));

    defparam mem_1_5.initval = 256'h0608240000001E360730397F3666407F03000800083E0000007A66127F030600 ;
    ROM256X1A mem_1_5 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_2_1));

    defparam mem_1_4.initval = 256'h0F1C244100003F7F0F797D7F7F6F404D06000800081C1C4100370C3A7F035F00 ;
    ROM256X1A mem_1_4 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_3_1));

    defparam mem_1_3.initval = 256'h59362463666669497949455349497F590C6008603E1C3E63005D186B14005F00 ;
    ROM256X1A mem_1_3 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_4_1));

    defparam mem_1_2.initval = 256'h51632436E6664949714B451649597F71186008E03E3E633E034F306B7F030600 ;
    ROM256X1A mem_1_2 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_5_1));

    defparam mem_1_1.initval = 256'h0341241C80004F7F037E671C6373427F30000880082A411C077A662E7F030000 ;
    ROM256X1A mem_1_1 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_6_1));

    defparam mem_1_0.initval = 256'h0200240800000636033C27182262403E60000800080800000430462414000000 ;
    ROM256X1A mem_1_0 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_7_1));

    defparam mem_2_7.initval = 256'h8000000000000000000000000000000000000000000000000000000000000000 ;
    ROM256X1A mem_2_7 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_0_2));

    defparam mem_2_6.initval = 256'h80080060007300437F000000006600061C7F7F70630100007203631C2236001E ;
    ROM256X1A mem_2_6 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_1_2));

    defparam mem_2_5.initval = 256'h800C0030006707677F1F7F03327F5E0F3E7F7F60773F007F7301413E637F7C1F ;
    ROM256X1A mem_2_5 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_2_2));

    defparam mem_2_4.initval = 256'h80067F18414D4F3C303F7F4173197F0963180E401C7F417F511D5D6341497E5D ;
    ROM256X1A mem_2_4 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_3_2));

    defparam mem_2_3.initval = 256'h80037F0C415978181860407F59097149410C1C4108417F08414949414149135D ;
    ROM256X1A mem_2_3 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_4_2));

    defparam mem_2_2.initval = 256'h800641067F71783C3060407F4D7F217F63060E7F7F407F08637F7F7F637F1341 ;
    ROM256X1A mem_2_2 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_5_2));

    defparam mem_2_1.initval = 256'h800C41037F634F677F3F7F416F7F3F7F3E7F7F7F7F70417F3E7F7F7F3E7F7E7F ;
    ROM256X1A mem_2_1 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_6_2));

    defparam mem_2_0.initval = 256'h80080001004707437F1F7F0326411E411C7F7F414130007F1C4141411C417C3E ;
    ROM256X1A mem_2_0 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_7_2));

    defparam mem_3_7.initval = 256'h0000000000000000000000000000000000000000000000000000000000000000 ;
    ROM256X1A mem_3_7 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_0_3));

    defparam mem_3_6.initval = 256'h00010000000000443C0040000018841800007800440000780400004000304000 ;
    ROM256X1A mem_3_6 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_1_3));

    defparam mem_3_5.initval = 256'h0003080041647C6C7C1C7C24241CFC3C38787C006C7D007C7C02187F28787800 ;
    ROM256X1A mem_3_5 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_2_3));

    defparam mem_3_4.initval = 256'h00020877414CFC38703C3C447404F8247C7C1C4038FD4004F8035C3F6C483C04 ;
    ROM256X1A mem_3_4 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_3_3));

    defparam mem_3_3.initval = 256'h00033E77775CA0103860407F544CA4A44404387F10807D08A449544944485407 ;
    ROM256X1A mem_3_3 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_4_3));

    defparam mem_3_2.initval = 256'h000177003E74A0387060403E547824F84404187F7F807D7FA47F5448443F5403 ;
    ROM256X1A mem_3_2 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_5_3));

    defparam mem_3_1.initval = 256'h000341000864BC6C7C3C7C045C7C3CFC7C7C7C417FE0447FBC7E7C787C7F7400 ;
    ROM256X1A mem_3_1 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_6_3));

    defparam mem_3_0.initval = 256'h00024100084C9C443C1C3C0048441884387C7C00416000419848383038412000 ;
    ROM256X1A mem_3_0 (.AD7(Address[7]), .AD6(Address[6]), .AD5(Address[5]), 
        .AD4(Address[4]), .AD3(Address[3]), .AD2(Address[2]), .AD1(Address[1]), 
        .AD0(Address[0]), .DO0(mdL0_7_3));

    MUX41 mux_7 (.D0(mdL0_0_0), .D1(mdL0_0_1), .D2(mdL0_0_2), .D3(mdL0_0_3), 
        .SD1(Address[8]), .SD2(Address[9]), .Z(Q[7]));

    MUX41 mux_6 (.D0(mdL0_1_0), .D1(mdL0_1_1), .D2(mdL0_1_2), .D3(mdL0_1_3), 
        .SD1(Address[8]), .SD2(Address[9]), .Z(Q[6]));

    MUX41 mux_5 (.D0(mdL0_2_0), .D1(mdL0_2_1), .D2(mdL0_2_2), .D3(mdL0_2_3), 
        .SD1(Address[8]), .SD2(Address[9]), .Z(Q[5]));

    MUX41 mux_4 (.D0(mdL0_3_0), .D1(mdL0_3_1), .D2(mdL0_3_2), .D3(mdL0_3_3), 
        .SD1(Address[8]), .SD2(Address[9]), .Z(Q[4]));

    MUX41 mux_3 (.D0(mdL0_4_0), .D1(mdL0_4_1), .D2(mdL0_4_2), .D3(mdL0_4_3), 
        .SD1(Address[8]), .SD2(Address[9]), .Z(Q[3]));

    MUX41 mux_2 (.D0(mdL0_5_0), .D1(mdL0_5_1), .D2(mdL0_5_2), .D3(mdL0_5_3), 
        .SD1(Address[8]), .SD2(Address[9]), .Z(Q[2]));

    MUX41 mux_1 (.D0(mdL0_6_0), .D1(mdL0_6_1), .D2(mdL0_6_2), .D3(mdL0_6_3), 
        .SD1(Address[8]), .SD2(Address[9]), .Z(Q[1]));

    MUX41 mux_0 (.D0(mdL0_7_0), .D1(mdL0_7_1), .D2(mdL0_7_2), .D3(mdL0_7_3), 
        .SD1(Address[8]), .SD2(Address[9]), .Z(Q[0]));



    // exemplar begin
    // exemplar end

endmodule
