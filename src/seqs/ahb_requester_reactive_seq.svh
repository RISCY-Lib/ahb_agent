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

// Class: ahb_agent_pkg.ahb_requester_reactive_seq
// The base sequence extended by reactive sequences used for AHB Requestor agents
class ahb_requester_reactive_seq#(
    `_AHB_AGENT_PARAM_DEFS
) extends uvm_sequence#(ahb_transaction#(`_AHB_AGENT_PARAM_MAP));
    `uvm_object_param_utils(ahb_requester_reactive_seq#(`_AHB_AGENT_PARAM_MAP))
    `uvm_type_name_decl("ahb_requester_reactive_seq")
    `uvm_declare_p_sequencer(ahb_sequencer#(`_AHB_AGENT_PARAM_MAP))

    // Group: Constructors
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Constructor: new
    function new(string name = "ahb_requester_reactive_seq");
        super.new(name);
    endfunction : new

    // Group: Body Methods
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Task: body
    virtual task body();
        `uvm_fatal(get_type_name(), "Using base ahb_requester_reactive_seq directly.")
    endtask

endclass : ahb_requester_reactive_seq