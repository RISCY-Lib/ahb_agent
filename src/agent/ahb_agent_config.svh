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

// Class: ahb_agent_pkg.ahb_agent_config
class ahb_agent_config extends uvm_object;
    `uvm_component_utils(ahb_agent_config)

    // Group: Class Properties
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Property: is_active
    // Determine whether the agent is passive or active
    uvm_active_passive_enum is_active = UVM_ACTIVE;

    // Property: no_parameter_check
    // Determine whether the agent should produce errors when the parameters are set incorrectly
    bit no_parameter_check = 1'b0;
endclass : ahb_agent_config