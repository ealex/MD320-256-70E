## Description

This project creates a driver for the MD320.256 electroluminescent (TFEL) display.  
The MD320.256 is 320 columns by 256 row flat panel display with a resolution of 80 dots
per inch.  
The digital flat panel interface is designed to match the needs of most systems. The display may be driven at frame rates up to 75 Hz.  
The MD320.256 display requires +5 V and +11 V to +30 V (Vcc1, Vcc2) power and 4 basic signals to operate:
1. Video Data or pixel information (VID)
2. Video Clock, pixel clock, or dot clock (VCLK)
3. Horizontal Sync (HS)
4. Vertical Sync (VS)

The device's datasheet corrensponds to LJ320U27 from the attached datasheets [Sharp_LCD_EL_1990](docs/Sharp_LCD_EL_1990.pdf).  
Extra details are present in the other files from the doc folder.  

## FPGA

The project is created around the [MACHXO2](https://www.latticesemi.com/en/Products/FPGAandCPLD/MachXO2) series.  

The screen is split into 8*8 pixel blocks that create a 40 column by 32 rows character only display.  
The design can use a normal video RAM but that will require `320*256/8=10240` bytes of RAM - not available on the chosen device.  
There are several functional blocks used by the design:
1. The timing generator: a 3 bit counter `phase_counter` that controls the delay between the sync, data and clock signals.  
   It's used to allow for enough time for the RAM / ROM and sync generator modules to generate and propagate their outputs.
   It's implementd as a 3 bit that rolls over at `3'b111`.
2. The panel sync generator in `sync.v`.  
   This module provides HSYNC(`out_display_hs`), VSYNC(`out_display_vs`) and CLK(`out_display_clock`) to the display.
   It provides the X(`out_coord_x`) and Y(`out_coord_y`) coordinates for the video ram / character generator.
   It uses 2 of the states of the timing generator
   - `3'b000`
    - `out_display_clock` is set to `1'b0`
    - `display_x_cnt` and `display_y_cnt` are incremented and reset when they reach `HS_PERIOD` and `VS_PERIOD`
   - `3'b100` when `out_display_clock` is set to `1'b1`
3. The working memory `character_ram` that implements a dual-port RAM of 2048 bytes. The screen uses only 1280 bytes.  
   The read port is used by the system and it's directly linked to the font ROM by this rule: `character = RAM[(coord_x/8)+(40*(coord_y/8))]`.
4. The font ROM `font_rom` that implements a 2048 bytes ROM. It stores 256 characters in an 8x8 matrix.
   The pixel data is generatig by `fontRomAddr = (8*character)+coord_y[2:0]` and `out_display_data = ROM[fontRomAddr][coord_x[2:0]]`
   This can be reduced to 1024 bytes, to implement only the first 127 characters.


