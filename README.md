
# 8x1 Multiplexer UVM Testbench

A Universal Verification Methodology (**UVM**) based testbench repository for verifying an **8x1 multiplexer** implemented in Verilog or SystemVerilog.

## 🧾 Overview

This project includes:

- ✅ RTL design of a standard 8x1 multiplexer  
- 🧪 A complete **UVM-based testbench** for functional and coverage-driven verification  
- ⚙️ Simulation scripts for compiling and executing tests

## 🔩 8x1 Multiplexer Functionality

**Inputs:**

- `IN0` to `IN7`: 8 single-bit data inputs  
- `S0`, `S1`, `S2`: 3-bit selector input

**Output:**

- `OUT`: Single-bit output, determined by the select inputs

| Select Inputs (`S2 S1 S0`) | Output `Y` |
|---------------------------|-------------|
| 000                       | A0          |
| 001                       | A1          |
| 010                       | A2          |
| 011                       | A3          |
| 100                       | A4          |
| 101                       | A5          |
| 110                       | A6          |
| 111                       | A7          |

## 📁 Repository Structure
```
.
├── dst_agent
│   ├── mux_rd_agent.sv
│   ├── mux_rd_mon.sv
│   └── mux_rd_xtn.sv
├── intf
│   └── mux_intf.sv
├── rtl
│   └── mux_8x1.sv
├── sim
│   └── Makefile
├── src_agent
│   ├── mux_wr_agent.sv
│   ├── mux_wr_drv.sv
│   ├── mux_wr_mon.sv
│   ├── mux_wr_seqr.sv
│   ├── mux_wr_seqs.sv
│   └── mux_wr_xtn.sv
├── tb
│   ├── mux_config.sv
│   ├── mux_env.sv
│   ├── mux_scoreboard.sv
│   └── mux_top.sv
└── test
    ├── mux_pkg.sv
    └── mux_test.sv
```
## 🚀 Getting Started

- Synopsys VCS has been used for compilation and simulation. So it's pre-requisite if you want to simulate the project using the make commands provided.
- The make targets have been specified for every step in the verification have a look at the Makefile for specific commands.

## 🧪 Test Descriptions

The UVM testbench applies mainly two testcases:

- Base test for checking the testbench functionality
- All input insertion for checking DUV functionality

## 📼 Output Waveform

After running the simulation, the waveform file (e.g., `wavebase.fsdb`) will be generated. You can view it using:

`make view_wave_base` 

The output waveforms obtained are as follows:

<img src="/images/mux_waveform_zoomed.png" width="800">

<img src="/images/mux_waveform_full.png" width="800">

## 📊 Coverage Report

Functional and code coverage is collected using Synopsys VCS. The regression test is run to simulate both the testcases and then all of the coverage reports are merged.

- To run the regression test use the make target:
`make regress`
- This will run the regression test as well as use the `report` target to merge the coverage reports.

The coverage reports obtained are as follows:

<img src="/images/mux_covergroups.png" width="600">

<img src="/images/mux_line_coverage.png" width="600">


> Happy verifying! 🧑‍💻✅
