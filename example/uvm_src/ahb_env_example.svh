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

class ahb_env_example extends uvm_env;
    `uvm_component_utils(ahb_env_example)

    typedef ahb_agent#(
        .DATA_WIDTH(32),
        .ADDR_WIDTH(32),
        .HBURST_WIDTH(0),
        .HPROT_WIDTH(4),
        .HMASTER_WIDTH
    ) example_agent;

    // Group: Class Properties
    ////////////////////////////////////////////////////////////////////////////////////////////////

    example_agent completer_agent;
    example_agent requester_agent;

    // Group: Constructor
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Constructor: new
    function new(string name="ahb_env_example", uvm_component parent=null);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        completer_agent = example_agent::type_id::create("completer_agent", this);
        completer_agent.m_cfg = ahb_agent_config::type_id::create("completer_cfg");
        completer_agent.m_cfg.agent_mode = AHB_COMPLETER_AGENT;
        completer_agent.m_cfg.is_active = UVM_ACTIVE;

        requester_agent = example_agent::type_id::create("requester_agent", this);
        requester_agent.m_cfg = ahb_agent_config::type_id::create("completer_cfg");
        requester_agent.m_cfg.agent_mode = AHB_REQUESTER_AGENT;
        requester_agent.m_cfg.is_active = UVM_ACTIVE;

    endfunction : build_phase

endclass : ahb_env_example
