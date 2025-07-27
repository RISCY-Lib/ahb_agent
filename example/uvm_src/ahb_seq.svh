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

// Class: ahb_tb_example_pkg.ahb_seq
class ahb_seq extends uvm_sequence#(
    ahb_transaction#(
        .DATA_WIDTH(32),
        .ADDR_WIDTH(32),
        .HBURST_WIDTH(0),
        .HPROT_WIDTH(4),
        .HMASTER_WIDTH(0)
    )
);
    `uvm_object_utils(ahb_seq)

    logic[31:0] addr_q[$];

    function new(string name="ahb_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        repeat(10) begin
            ahb_transaction#(.DATA_WIDTH(32), .ADDR_WIDTH(32)) trans;

            trans = ahb_transaction#(.DATA_WIDTH(32), .ADDR_WIDTH(32))::type_id::create("trans");

            start_item(trans);
            trans.rand_type = AHB_SUBORDINATE_AGENT;
            void'(trans.randomize());
            `uvm_info(get_type_name(), $sformatf("Sending Transaction: %s", trans.sprint()), UVM_LOW)
            if (trans.write == AHB_WRITE)
                addr_q.push_back(trans.addr);
            finish_item(trans);
        end

        while(addr_q.size() > 0) begin
            ahb_transaction#(.DATA_WIDTH(32), .ADDR_WIDTH(32)) trans;

            trans = ahb_transaction#(.DATA_WIDTH(32), .ADDR_WIDTH(32))::type_id::create("trans");

            start_item(trans);
            trans.rand_type = AHB_SUBORDINATE_AGENT;
            trans.addr = addr_q.pop_front();
            trans.write = AHB_READ;
            `uvm_info(get_type_name(), $sformatf("Sending Transaction: %s", trans.sprint()), UVM_LOW)
            finish_item(trans);
        end
    endtask : body
endclass : ahb_seq