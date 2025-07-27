/************************************************************************************
 * A full-featured AHB UVM Agent
 * Copyright (C) 2025  RISCY-Lib Contributors
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 ************************************************************************************/

module tb();
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import ahb_tb_example_pkg::*;

    logic hclk;
    logic hresetn;

    `AHB_IF_INST(32, 32, 0, 4, 0, AHB, hclk, hresetn)

    initial begin
        hclk = 1'b0;
        forever begin
            #10ns;
            hclk = ~hclk;
        end
    end

    initial begin
        hresetn = 1'b0;

        repeat(3) begin
            @(posedge hclk);
        end

        hresetn = 1'b1;
    end

    initial begin
        run_test();
    end
endmodule : tb
