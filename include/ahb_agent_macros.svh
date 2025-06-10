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

`ifndef __AHB_AGENT_MACROS__SVH__
`define __AHB_AGENT_MACROS__SVH__

`define _AHB_AGENT_PARAM_DEFS \
    parameter int ADDR_WIDTH = 32,  \
    parameter int DATA_WIDTH = 32,  \
    parameter int HBURST_WIDTH = 3, \
    parameter int HPROT_WIDTH = 4,  \
    parameter int HMASTER_WIDTH = 0

`define _AHB_AGENT_PARAM_MAP \
    .ADDR_WIDTH(ADDR_WIDTH),      \
    .DATA_WIDTH(DATA_WIDTH),      \
    .HBURST_WIDTH(HBURST_WIDTH),  \
    .HPROT_WIDTH(HPROT_WIDTH),    \
    .HMASTER_WIDTH(HMASTER_WIDTH)

`define AHB_IF_INST(ADDR, DATA, HBURST, HPROT, HMASTER, IF_NAME=AHB, CLK_NAME=hclk, RST_NAME=hresetn) \
    ahb_vip_if #(                            \
        .ADDR_WIDTH(ADDR),                   \
        .DATA_WIDTH(DATA),                   \
        .HBURST_WIDTH(HBURST),               \
        .HPROT_WIDTH(HPROT),                 \
        .HMASTER_WIDTH(HMASTER)              \
    ) IF_NAME (                              \
        .hclk(CLK_NAME),                     \
        .hreset_n(RST_NAME)                  \
    );                                       \
    initial begin                            \
        uvm_config_db#(                      \
            virtual ahb_vip_if #(            \
                .ADDR_WIDTH(ADDR),           \
                .DATA_WIDTH(DATA),           \
                .HBURST_WIDTH(HBURST),       \
                .HPROT_WIDTH(HPROT),         \
                .HMASTER_WIDTH(HMASTER)      \
            )                                \
        )::set(null, "*", "m_vif", IF_NAME); \
    end

`endif // __AHB_AGENT_MACROS__SVH__