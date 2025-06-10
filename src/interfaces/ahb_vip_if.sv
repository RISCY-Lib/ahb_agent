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

`include "ahb_agent_macros.svh"

// Interface: ahb_vip_if
interface ahb_vip_if #(
    `_AHB_AGENT_PARAM_DEFS
)(
    logic hreset_n,
    logic hclk
);

    localparam int _STRB_WIDTH = DATA_WIDTH/8;
    localparam int _HBURST_WIDTH = (HBURST_WIDTH == 0) ? 3 : HBURST_WIDTH;
    localparam int _HPROT_WIDTH = (HPROT_WIDTH == 0) ? 4 : HPROT_WIDTH;
    localparam int _HMASTER_WIDTH = (HMASTER_WIDTH == 0) ? 1 : HMASTER_WIDTH;

    // Group: Manager Signals
    ////////////////////////////////////////////////////////////////////////////////////////////////

    logic [    ADDR_WIDTH-1:0] haddr;
    logic [  HBURST_WIDTH-1:0] hburst;
    logic                      hmastlock;
    logic [  _HPROT_WIDTH-1:0] hprot;
    logic [               2:0] hsize;
    logic                      hnonsec;
    logic                      hexcl;
    logic [_HMASTER_WIDTH-1:0] hmaster;
    logic [               1:0] htrans;
    logic [    DATA_WIDTH-1:0] hwdata;
    logic [   _STRB_WIDTH-1:0] hwstrb;
    logic                      hwrite;

    // Group: Subordinate Signals
    ////////////////////////////////////////////////////////////////////////////////////////////////

    logic [DATA_WIDTH-1:0] hrdata;
    logic                  hreadyout;
    logic                  hresp;
    logic                  hexokay;

    // Group: Decoder Signals
    ////////////////////////////////////////////////////////////////////////////////////////////////

    logic hsel;

    // Group: Multiplexor Signals
    ////////////////////////////////////////////////////////////////////////////////////////////////

    logic hready;

endinterface : ahb_vip_if