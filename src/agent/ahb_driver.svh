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

// Class: ahb_agent_pkg.ahb_driver
class ahb_driver#(`_AHB_AGENT_PARAM_DEFS) extends uvm_driver#(ahb_transaction);
    `uvm_component_param_utils(ahb_driver#(`_AHB_AGENT_PARAM_MAP))
    `uvm_type_name_decl("ahb_driver")

    // Group: Class Properties
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Reference: m_vif
    // The virtual interface
    virtual ahb_vip_if#(`_AHB_AGENT_PARAM_MAP) m_vif;

    // Reference: m_cfg
    // The agent configuration
    ahb_agent_config m_cfg;

    // Group: Constructors
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Constructor: new
    function new(string name = "ahb_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    // Group: UVM Build Phases
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Function: build_phase
    // The build_phase for the ahb_driver
    //
    // Performs the following
    // - Fetches the config if it isn't set
    // - Fetches the virtual interface if it isn't set in the config
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase):
    endfunction : build_phase

    // Group: UVM Run Phases
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Task: run_phase
    // The UVM Run-Phase
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);

        if (m_cfg.agent_mode == AHB_SUBORDINATE_AGENT) begin
            subordinate_run_phase(phase);
        end
        // else if (m_cfg.agent_mode == AHB_MANAGER_AGENT) begin
        //     manager_run_phase(phase);
        // end
        else begin
            `uvm_error(
                get_type_name(),
                $sformatf(
                    "Driver not implmented for selected agent_mode: %s",
                    m_cfg.agent_mode.name()
                )
            )
        end
    endtask : run_phase

    // Task: subordinate_run_phase
    // The UVM Run-Phase for a subordinate agent
    virtual task subordinate_run_phase(uvm_phase phase);
        ahb_transaction addr_trans;  // The transaction in the address phase
        ahb_transaction data_trans;  // The transaction in the data phase

        addr_trans = null;
        data_trans = null;

        m_vif.haddr     = '0;
        m_vif.hburst    = SINGLE;
        m_vif.hmastlock = 1'b0;
        m_vif.hprot     = (HPROT_WIDTH == 7) ? 7'b000_0011 : 4'b0011;
        m_vif.hsize     = (DATA_WIDTH <= 8 )  ? BYTE_SIZE         :
                          (DATA_WIDTH <= 16)  ? HALFWORD_SIZE     :
                          (DATA_WIDTH <= 32)  ? WORD_SIZE         :
                          (DATA_WIDTH <= 64)  ? DOUBLEWORD_SIZE   :
                          (DATA_WIDTH <= 128) ? FOUR_WORD_SIZE    :
                          (DATA_WIDTH <= 256) ? EIGHT_WORD_SIZE   :
                          (DATA_WIDTH <= 512) ? SIXTEEN_WORD_SIZE :
                                                THIRTY_TWO_WORD_SIZE;
        m_vif.hnonsec   = 1'b1;
        m_vif.hexcl     = 1'b0;
        m_vif.hmaster   = '0;
        m_vif.htrans    = IDLE;
        m_vif.hwdata    = '0;
        m_vif.hwstrb    = '1;
        m_vif.hwrite    = 1'b0;

        m_vif.hsel      = 1'b0;
        m_vif.hready    = 1'b1;

        forever begin
            if (addr_trans == null && data_trans == null) begin
                seq_item_port.get(addr_trans);
            end

            @(posedge m_vif.hclk);

            m_vif.haddr = addr_trans.addr;
            m_vif.hburst = addr_trans.burst;

        end
    endtask : subordinate_run_phase

    // Task: manager_run_phase
    // The UVM Run-Phase for a manager agent
    virtual task manager_run_phase(uvm_phase phase);

    endtask : manager_run_phase

endclass