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

    // Property: rand_type
    // The agent mode to use when randomizing.
    // Only randomizes values which should be set by a sequence
    // Note: rand_type = AHB_DECODER_AGENT causes all values to be randomized
    ahb_agent_mode_e rand_type = AHB_DECODER_AGENT;

    // Property: write
    // Whether the transaction is read or write
    // Set by the sequence in AHB_SUBORDINATE_AGENT mode.
    // Set by the agent in AHB_MANAGER_MODE
    rand ahb_write_e write = AHB_WRITE;

    // Property: addr
    // The address of the transaction
    // Set by the sequence in AHB_SUBORDINATE_AGENT mode.
    // Set by the agent in AHB_MANAGER_AGENT mode.
    rand logic [ADDR_WIDTH-1:0] addr = '0;

    // Property: data
    // The data transmitted by this transaction
    rand logic [DATA_WIDTH-1:0] data = '0;

    // Property: size
    // The transaction size
    // Set by the sequence in AHB_SUBORDINATE_AGENT mode.
    // Set by the agent in AHB_MANAGER_AGENT mode.
    rand ahb_size_e size = WORD_SIZE;

    // Property: wait_states
    // The number of wait states in the transaction.
    // Set by sequence in AHB_MANAGER_AGENT mode.
    // Set by agent in AHB_SUBORDINATE_AGENT mode.
    rand int wait_states = 0;

    // Group: Constraints
    ////////////////////////////////////////////////////////////////////////////////////////////////

    constraint write_before_data_c { solve write before data; };
    constraint size_before_alignment_c { solve size before addr; };

    constraint valid_size_c {
        DATA_WIDTH <= 8  -> size <= BYTE_SIZE;
        DATA_WIDTH <= 16 -> size <= HALFWORD_SIZE;
        DATA_WIDTH <= 32 -> size <= WORD_SIZE;
        DATA_WIDTH <= 64 -> size <= DOUBLEWORD_SIZE;
        DATA_WIDTH <= 128 -> size <= FOUR_WORD_SIZE;
        DATA_WIDTH <= 256 -> size <= EIGHT_WORD_SIZE;
        DATA_WIDTH <= 512 -> size <= SIXTEEN_WORD_SIZE;
        DATA_WIDTH <= 1024 -> size <= THIRTY_TWO_WORD_SIZE;
    };

    constraint addr_alignment_c {
        size == HALFWORD_SIZE -> addr[0] == 1'b0;
        size == WORD_SIZE -> addr[1:0] == 2'b00;
        size == DOUBLEWORD_SIZE -> addr[2:0] == 3'b000;
        size == FOUR_WORD_SIZE -> addr[3:0] == 4'h0;
        size == EIGHT_WORD_SIZE -> addr[4:0] == 5'h00;
        size == SIXTEEN_WORD_SIZE -> addr[5:0] == 6'h00;
        size == THIRTY_TWO_WORD_SIZE -> addr[6:0] == 7'h00;
    };

    function void pre_randomize();
        super.pre_randomize();

        if (rand_type == AHB_DECODER_AGENT) begin
            return;
        end
        if (rand_type == AHB_SUBORDINATE_AGENT) begin
            wait_states.rand_mode(0);
            return;
        end
        if (rand_type == AHB_MANAGER_AGENT) begin
            write.rand_mode(0);
            addr.rand_mode(0);
            size.rand_mode(0);
            return;
        end

    endfunction : pre_randomize

    // Group: Constructors
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Constructor: new
    function new(string name = "ahb_transaction");
        super.new(name);
    endfunction : new

    // Group: UVM do_* methods
    ////////////////////////////////////////////////////////////////////////////////////////////////o

    // Function: do_print
    virtual function void do_print(uvm_printer printer);
        `uvm_print_enum(ahb_agent_mode_e, rand_type)
        `uvm_print_enum(ahb_write_e, write)
        printer.print_field("addr", addr, $bits(addr));
        printer.print_field("data", data, $bits(data));
        `uvm_print_enum(ahb_size_e, size)
        `uvm_print_int(wait_states, $size(wait_states))
    endfunction : do_print
endclass : ahb_transaction
