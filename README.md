# YAPP Router - UVM Verification
 
A UVM verification environment for the YAPP packet router, written in
SystemVerilog and built step by step through a hands-on UVM course project
(Cadence / KamaTech). Simulated with Cadence Xcelium.
 
## Overview
 
The YAPP router receives packets on a single input port and forwards each
packet to one of three output channels. This project builds a layered UVM
testbench that drives packets into the router, monitors its outputs, and
checks that every packet is routed correctly.
 
## The DUT
 
**Packet format**
 
| Field | Size | Description |
|---|---|---|
| Header: address | 2 bits | Target output channel |
| Header: length | 6 bits | Number of payload bytes |
| Payload | `length` bytes | Data |
| Parity | 1 byte | XOR of the header and the payload, used to detect transmission errors |
 
**Behavior checked by the testbench**
 
- Valid output channels are 0, 1 and 2. A packet addressed to channel 3 is
  illegal and is dropped.
- A configuration register (`maxpktsize`) sets the largest accepted packet.
  A packet whose length is greater than this value is dropped.
- A parity byte is used to detect bad packets.
 
## Testbench architecture
 
- **YAPP UVC** - packet data item (with constraints), sequencer, driver, monitor
- **HBUS UVC** - host interface used to program the router registers
- **Clock and Reset UVC** - generates the clock and reset
- **Channel UVCs (x3)** - one per output channel, respond to the router outputs
- **Scoreboard / Router module UVC** - built with TLM, compares packets sent
  with packets received
- **Register model** - UVM register model of the router registers
- **Virtual sequencer** - runs multichannel sequences across the UVCs
- **UVM factory and config_db** - tests change behavior (for example, short
  packets, passive agent) without changing the testbench code
 
## Tests
 
All tests extend `base_test`, which builds the testbench (`router_tb`), sets a
default YAPP sequence, prints the UVM topology, sets a 200 ns drain time and
checks for unused configuration settings. Select a test with
`+UVM_TESTNAME=<test_name>`.
 
| Test | What it does |
|---|---|
| `base_test` | Base class for all tests. Runs the default `yapp_5_packets` sequence |
| `test2` | Empty extension of `base_test` (placeholder) |
| `short_packet_test` | Factory type override: `yapp_packet` replaced by `short_yapp_packet` |
| `set_config_test` | Sets the YAPP agent to passive using `uvm_config_int` |
| `incr_payload_test` | Runs `yapp_incr_payload_seq` with short packets |
| `exhaustive_seq_test` | Runs `yapp_exhaustive_seq` with short packets |
| `YAPP_UVC` | Runs `yapp_012_seq` with short packets |
| `simple_test` | `yapp_012_seq` on the YAPP agent, response sequences on the channel UVCs, clock and reset sequence |
| `simple_mcseq_test` | Multichannel sequence (`router_simple_mcseq`) from the virtual sequencer, with channel responses and clock/reset |
 
## Lab progression
 
| Lab | Topic |
|---|---|
| 1 | Packet data item and UVM automation |
| 2 | Test and testbench components |
| 3 | A simple UVC and the UVM phases |
| 4 | Factory methods and test configuration |
| 5 | Sequences and sequence library |
| 6 | Connecting the UVC to the DUT with virtual interfaces |
| 7 | Integrating multiple UVCs |
| 8 | Multichannel sequences and system-level tests |
| 9A | Scoreboard using TLM |
| 9B | Router module UVC |
| 11A / 11B | Register model: generation and integration |
 
## Project structure
 
```
yapp/             YAPP UVC
channel/          Output channel UVC
hbus/             HBUS UVC
clock_and_reset/  Clock and reset UVC
router_rtl/       Router RTL (DUT)
labXX_*/          Testbench and tests for each lab
```
 
## How to run
 
```
xrun -f run.f
```
 
Optional: add `-gui` for waveforms, or the coverage options for coverage
collection. Choose a test with `+UVM_TESTNAME=<test_name>`.
 

## Notes
 
The DUT, the HBUS and Clock/Reset UVCs and other base files come from the
course material. The testbench work in the lab folders is mine.
