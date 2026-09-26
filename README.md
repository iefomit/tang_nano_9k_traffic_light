# Tang Nano 9K Traffic Light

This is a simple traffic light written in Verilog for the Tang Nano 9K. It is meant to work almost like the traffic light circuit on the breadboard.

The lights run in this order:

* Green for 3 seconds
* Yellow for 1 second
* Red for 3 seconds
* Then back to green

## How it works

The Tang Nano has a 27 MHz clock, which is much faster than we need for a traffic light. The code counts the clock cycles until one second has passed, then updates the current light.

The traffic light itself is a small state machine with three states:

```text
Green → Yellow → Red → Green
```

Pressing S2 resets the circuit and starts it at green.

## Pins

The `.cst` file uses these Tang Nano 9K pins:

* Clock: pin 52
* Green LED: pin 10
* Yellow LED: pin 11
* Red LED: pin 13
* S2 reset button: pin 3

The onboard LEDs are active-low, so a `0` turns an LED on.

## Running it with Lushay Code

Open this folder in VS Code with Lushay Code and the OSS-CAD Suite toolchain installed.

Make sure `traffic_light.lushay.json` is selected as the project. Then use **FPGA Toolchain → Build and Program**.

The project uses `top.v` as the top-level Verilog file and `tangnano9k.cst` for the pin assignments.

## Command line

With OSS-CAD Suite installed, you can also build and program it from the terminal:

```bash
make
make load
```

`make load` programs the resulting bitstream to the Tang Nano 9K.
