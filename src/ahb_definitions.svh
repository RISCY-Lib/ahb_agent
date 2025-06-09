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

// Enum: ahb_agent_mode_e
typedef enum {
    AHB_SUBORDINATE_AGENT,
    AHB_MANAGER_AGENT,
    AHB_DECODER_AGENT,
    AHB_MULTIPLEXOR_AGENT
} ahb_agent_mode_e;

// Enum: ahb_burst_e
typedef enum logic[2:0] {
    SINGLE = 3'b000,
    INCR   = 3'b001,
    WRAP4  = 3'b010,
    INCR4  = 3'b011,
    WRAP8  = 3'b100,
    INCR8  = 3'b101,
    WRAP16 = 3'b110,
    INCR16 = 3'b111
} ahb_burst_e;

// Struct: ahb_hprot_4bit_t
typedef struct packed {
    logic data_access;
    logic privileged;
    logic bufferable;
    logic cacheable;
} ahb_hprot_4bit_t;

// Struct: ahb_hprot_7bit_t
typedef struct packed {
    logic data_access;
    logic privileged;
    logic bufferable;
    logic modifiable;
    logic lookup;
    logic allocate;
    logic shareable;
} ahb_hprot_7bit_t;

// Enum: ahb_size_e
typedef enum logic[2:0] {
    BYTE_SIZE            = 3'b000,
    HALFWORD_SIZE        = 3'b001,
    WORD_SIZE            = 3'b010,
    DOUBLEWORD_SIZE      = 3'b011,
    FOUR_WORD_SIZE       = 3'b100,
    EIGHT_WORD_SIZE      = 3'b101,
    SIXTEEN_WORD_SIZE    = 3'b110,
    THIRTY_TWO_WORD_SIZE = 3'b111
} ahb_size_e;

// Enum: ahb_trans_e
typedef enum logic[1:0] {
    IDLE   = 2'b00,
    BUSY   = 2'b01,
    NONSEQ = 2'b10,
    SEQ    = 2'b11
} ahb_trans_e;