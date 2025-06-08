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

// Package: ahb_agent_pkg
package ahb_agent_pkg;

    // UVM Imports
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Agent Imports

    `include "agent/ahb_agent_config.svh"
    `include "agent/ahb_transaction.svh"
    `include "agent/ahb_monitor.svh"
    `include "agent/ahb_driver.svh"
    `include "agent/ahb_cov.svh"
    `include "agent/ahb_agent.svh"

endpackage : ahb_agent_pkg