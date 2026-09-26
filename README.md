# Tang Nano 9K Traffic Light

A Verilog implementation of the same 3-1-3 traffic-light behavior as the breadboard circuit:

- Green for 3 seconds
- Yellow for 1 second
- Red for 3 seconds
- Repeat

## Tang Nano 9K connections

- 27 MHz clock: pin 52
- Green LED: pin 10
- Yellow LED: pin 11
- Red LED: pin 13
- S2 reset button: pin 3 (active-low)

The three onboard LEDs are active-low, so the Verilog drives `0` when a light should be ON.

## Lushay Code

Open this folder in VS Code with the Lushay Code extension installed and the OSS-CAD toolchain available.

Open `traffic_light.lushay.json`, then use **FPGA Toolchain -> Build and Program**.

The Lushay Code workflow automatically synthesizes the Verilog, places/routes it using the `.cst` constraints, creates the bitstream, and programs the Tang Nano 9K. The project format and workflow are documented by Lushay Labs.

## Command-line fallback

With OSS-CAD Suite installed:

```bash
make
make load
```

`make load` builds the bitstream if needed and writes it to flash with `openFPGALoader`.
