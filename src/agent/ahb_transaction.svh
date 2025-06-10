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

// Class: ahb_agent_pkg.ahb_transaction
// The AHB Transaction class
class ahb_transaction#(`_AHB_AGENT_PARAM_DEFS) extends uvm_sequence_item;
    `uvm_object_param_utils(ahb_transaction#(`_AHB_AGENT_PARAM_MAP))
    `uvm_type_name_decl("ahb_transaction")

    // Group: Class Properties
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Property: write
    // Whether the transaction is read or write
    rand ahb_write_e write = AHB_WRITE;

    // Property: addr
    // The address of the transaction
    rand logic [ADDR_WIDTH-1:0] addr = '0;

    // Property: data
    // The data transmitted by this transaction
    rand logic [DATA_WIDTH-1:0] data = '0;

    // Property: wait_states
    // The number of wait states in the transaction.
    // Set by sequence in AHB_MANAGER_AGENT mode.
    // Set by agent in AHB_SUBORDINATE_AGENT mode.
    int wait_states = 0;

    // Group: Constructors
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Constructor: new
    function new(string name = "ahb_transaction");
        super.new(name);
    endfunction : new

    // Group: UVM do_* methods
    ////////////////////////////////////////////////////////////////////////////////////////////////
endclass : ahb_transaction
