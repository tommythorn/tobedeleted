/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example_tommythorn (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

   // All output pins must be assigned. If not used, assign to 0.
   assign uo_out[6:0] = 0;
   assign uio_out = 0;
   assign uio_oe  = 0;

   reg [63:0] rf[31:0];
   reg [68:0]  dataaddr;

   assign uo_out[0] = dataaddr[68];

   always @(posedge clk) begin
      if (ui_in[1])
	dataaddr[68:5] <= rf[dataaddr[4:0]];
      else if (ui_in[2])
	rf[dataaddr[4:0]] <= dataaddr[68:5];
      else
	dataaddr <= {dataaddr[67:0], ui_in[0]};
      if (!rst_n)
	dataaddr <= 0;
   end
endmodule
