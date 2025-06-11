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

// Class: ahb_agent_pkg.ahb_monitor
// The UVM Monitor for the AHB agent
class ahb_monitor#(`_AHB_AGENT_PARAM_DEFS) extends uvm_monitor;
    `uvm_component_param_utils(ahb_monitor#(`_AHB_AGENT_PARAM_MAP))
    `uvm_type_name_decl("ahb_monitor")

    // Group: Class Properties
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Reference: m_vif
    // The virtual interface
    virtual ahb_vip_if#(`_AHB_AGENT_PARAM_MAP) m_vif;

    // Property: ap
    // The analysis port which this monitor uses to export to
    uvm_analysis_port #(ahb_transaction#(`_AHB_AGENT_PARAM_MAP)) ap;

    // Reference: m_cfg
    // The agent config for this AHB agent
    ahb_agent_config m_cfg;

    // Group: Constructors
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Constructor: new
    function new(string name="ahb_monitor", uvm_component parent=null);
        super.new(name, parent);
    endfunction : new

    // Group: UVM Build Phases
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Function: build_phase
    // The build_phase for the ahb_monitor
    //
    // Performs the following
    // - Create the analysis port
    // - Fetches the config if it isn't set
    // - Fetches the virtual interface
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        ap = new("ap", this);

        if (m_cfg == null) begin
            if (!uvm_config_db#(ahb_agent_config)::get(this, "", "m_cfg", m_cfg)) begin
                `uvm_fatal(
                    get_type_name(),
                    "Cannot get() configuration 'm_cfg' from uvm_config_db. Did you set() it?"
                )
            end
        end

        if (m_vif == null) begin
            if (!uvm_config_db#(virtual ahb_vip_if#(`_AHB_AGENT_PARAM_MAP))::get(
                this, "", m_cfg.vif_handle, m_vif
            )) begin
                `uvm_fatal(
                    get_type_name(),
                    $sformatf(
                        "Cannot get() configuration '%s' from uvm_config_db. Did you set() it?",
                        m_cfg.vif_handle
                    )
                )
            end
        end

    endfunction : build_phase

    // Group: UVM Run Phases
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Function: run_phase
    // The run_phase for the ahb_monitor
    virtual task run_phase(uvm_phase phase);
        ahb_transaction #(`_AHB_AGENT_PARAM_MAP) trans;

        forever begin
            @(posedge m_vif.hclk);

            if (!m_vif.hreset_n) begin
                trans = null;
                continue;
            end

            if (m_vif.hready) begin
                if (trans != null) begin
                    if (trans.write == AHB_READ) begin
                        trans.data = m_vif.hrdata;
                    end
                    else begin
                        trans.data = m_vif.hwdata;
                    end

                    ap.write(trans);
                    trans = null;
                end

                if (trans == null && m_vif.hsel && m_vif.htrans == NONSEQ) begin
                    trans = ahb_transaction#(`_AHB_AGENT_PARAM_MAP)::type_id::create("monitor_trans");
                    trans.addr = m_vif.haddr;
                    trans.write = ahb_write_e'(m_vif.hwrite);
                    trans.size = ahb_size_e'(m_vif.hsize);
                end
            end
            else begin
                if (trans != null) begin
                    trans.wait_states++;
                end
            end
        end

    endtask : run_phase

endclass : ahb_monitor