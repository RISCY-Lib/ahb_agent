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

// Interface: ahb_vip_drv_bfm
interface ahb_vip_drv_bfm
    import ahb_agent_pkg::*;
#(
    `_AHB_AGENT_PARAM_DEFS
) (
    ahb_vip_if ahb
);

    // Group: Members
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Property: proxy
    // The proxy to the UVM AHB Driver
    ahb_driver proxy;

    // Group: Driving Logic
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Task: drive_manager
    // Drive the packet as a manager agent (i.e. emulate the multiplexor, decoder, and subordinate)
    task drive_manager(ahb_transaction#(`_AHB_AGENT_PARAM_MAP) t);

    endtask : drive_manager

    // Task: drive_subordinate
    // Drive the package as a subordinate agent (i.e. emulate the multiplexor, decoder, and manager)
    task drive_subordinate(ahb_transaction#(`_AHB_AGENT_PARAM_MAP) t);

    endtask : drive_subordinate


endinterface : ahb_vip_drv_bfm