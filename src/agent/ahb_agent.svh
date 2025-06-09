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

// Class: ahb_agent_pkg.ahb_agent
class ahb_agent #(
    `_AHB_AGENT_PARAM_DEFS
) extends uvm_agent;
    `uvm_component_param_utils(ahb_agent#(`_AHB_AGENT_PARAM_MAP))
    `uvm_type_name_decl("ahb_agent")

    // Group: Class Properties
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Reference: m_cfg
    // The agent config for this AHB Agent
    ahb_agent_config m_cfg;

    // Group: Constructors
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Constructor: new
    function new(string name = "ahb_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    // Group: UVM Build Phases
    ////////////////////////////////////////////////////////////////////////////////////////////////

    // Function: build_phase
    // The build_phase for the AHB Agent.
    //
    // This phase performs the following
    // - Get the configuration object if not set
    // - Check the parameters fall within the AHB Spec
    //
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (m_cfg == null) begin
            if (!uvm_config_db#(ahb_agent_config)::get(this, "", "m_cfg", m_cfg)) begin
                `uvm_fatal(
                    get_type_name(),
                    "Cannot get() configuration 'm_cfg' from uvm_config_db. Did you set() it?"
                )
            end
        end

        check_params();

    endfunction : build_phase

    // Function: check_params
    // A function which checks that the params fall within the limits perscribed by the spec
    virtual function void check_params();
        if (m_cfg.no_parameter_check)
            return;

        if (ADDR_WIDTH < 10 || ADDR_WIDTH > 64) begin
            `uvm_warning(
                get_type_name(),
                $sformatf(
                    "ADDR_WIDTH is set to %0d. AHB Spec recommends ADDR_WIDTH between 10 and 64 inclusive. (Section 2.2)",
                    ADDR_WIDTH
                )
            )
        end

        if (!(HBURST_WIDTH == 0 || HBURST_WIDTH == 3)) begin
            `uvm_error(
                get_type_name(),
                $sformatf(
                    "HBURST_WIDTH is set to %0d. AHB Spec requires HBURST_WIDTH be either 0 or 3. (Section 2.2)",
                    HBURST_WIDTH
                )
            )
        end

        if (!(HPROT_WIDTH == 0 || HPROT_WIDTH == 4 || HPROT_WIDTH == 7)) begin
            `uvm_error(
                get_type_name(),
                $sformatf(
                    "HPROT_WIDTH is set to %0d. AHB Spec requires HPROT_WIDTH be 0, 4, or 7. (Section 2.2)",
                    HPROT_WIDTH
                )
            )
        end

        if (HMASTER_WIDTH < 0 || HMASTER_WIDTH > 8) begin
            `uvm_warning(
                get_type_name(),
                $sformatf(
                    "HMASTER_WIDTH is set to %0d. AHB Spec recommends HMASTER_WIDTH between 0 and 8 inclusive. (Section 2.2)",
                    HMASTER_WIDTH
                )
            )
        end

        if (!DATA_WIDTH inside {8, 16, 32, 64, 128, 256, 512, 1024}) begin
            `uvm_error(
                get_type_name(),
                $sformatf(
                    "DATA_WIDTH is set to %0d. AHB Spec requires DATA_WIDTH be 8, 16, 32, 64, 128, 256, 512, 1024. (Section 2.2)",
                    DATA_WIDTH
                )
            )
        end
        else if (DATA_WIDTH > 256 || DATA_WIDTH < 32) begin
            `uvm_warning(
                get_type_name(),
                $sformatf(
                    "DATA_WIDTH is set to %0d. AHB Spec recommends DATA_WIDTH be 32, 64, 128, 256. (Section 2.2)",
                    DATA_WIDTH
                )
            )
        end

    endfunction : check_params

endclass : ahb_agent