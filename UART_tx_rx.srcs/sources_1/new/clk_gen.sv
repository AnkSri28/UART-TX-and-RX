`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2023 10:49:59
// Design Name: 
// Module Name: clk_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_gen(
input clk, rst,
input [16:0] baud,
output reg  tx_clk, rx_clk
);
  
  
reg  t_clk = 0;
reg  r_clk = 0;
int  tx_max = 0;
int  rx_max = 0;
int  tx_count = 0;
int  rx_count = 0;

always @(posedge clk)begin
    if(rst)begin
        tx_max <= 0;
    end
    else begin
        case(baud)
            4800: tx_max = 14'd10416;
            9600: tx_max = 14'd5208;
            14400: tx_max = 14'd3472;
            default: tx_max =14'd5208;	
        endcase
    end
end

always @(posedge clk)begin
    if(rst)begin
        rx_max <= 0;
    end
    else begin
        rx_max <= tx_max/16;	
    end
end

always @(posedge clk)begin
    if(rst)begin
        tx_count <= 0;
        tx_clk <= 0;
    end
    else begin
        if(tx_count < tx_max)begin
            tx_count <= tx_count + 1;
            tx_clk <= tx_clk;
        end
        else begin
            tx_count <= 0;
            tx_clk <= ~tx_clk;
        end
    end
end

always @(posedge clk)begin
    if(rst)begin
        rx_count <= 0;
        rx_clk <= 0;
    end
    else begin
        if(rx_count < rx_max)begin
            rx_count <= rx_count + 1;
            rx_clk <= rx_clk;
        end
        else begin
            rx_count <= 0;
            rx_clk <= ~rx_clk;
        end
    end
end

endmodule
