🖥💾🖼FPGA Image Rotation & Display System (Cyclone V + HDMI) In this project, we designed and implemented a hardware system on FPGA (Cyclone V) to display and rotate an image on an HDMI monitor.
 The system supports both automatic and manual rotation at fixed angles (0°, 90°, 180°, 270°), with control via push buttons and switches.

 🔹 Main Features: 
 
 Image data stored in SRAM and transmitted to the display.
 
 Rotation control (automatic / manual) with selectable direction (clockwise / counterclockwise).
 
 Mode switching between image display and color bars test pattern.
 
 Timing generation for horizontal/vertical sync and frame management. 

Clock management (25 MHz for HDMI). 

Synchronization of inputs using state machines and two-flop synchronizers. 

Modular block design: Push Button Controller, Timing Generator, Data Generator, Clock Generator, Synchronizer, BCD-to-7seg, and Image Processor.

 🛠 Tools & Technologies: 

Quartus Prime – FPGA design, synthesis, and implementation (Cyclone V).

VHDL – Hardware Description Language for module design.

ModelSim – Simulation and functional verification of VHDL code.

📊 Outcome: A fully functional FPGA-based image rotation system capable of real-time HDMI output, controlled rotation, and display switching. The project demonstrated advanced digital logic design, hardware debugging, and system-level integration.

