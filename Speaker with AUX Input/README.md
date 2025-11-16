AUX Speaker – LM386 Audio Amplifier
This project is a simple DIY mono speaker that receives a standard 3.5mm AUX audio input.
The circuit mixes stereo (L/R) audio into mono, amplifies the signal using an LM386 audio amplifier, and drives an 8Ω speaker.
Features

•	Stereo AUX input (3.5mm jack)

•	Left/Right mixing to mono using 2k resistors

•	Volume control using a potentiometer

•	LM386 audio amplifier

•	Output to an 8Ω speaker

•	Power: 8V DC

Hardware Components

•	LM386 amplifier IC

•	3.5mm AUX connector

•	2 × 2kΩ resistors (L/R mixing)

•	10kΩ potentiometer (volume control)

•	Capacitors: 47nF, 470µF, 1µF

•	8Ω speaker

•	Power supply (8V)

Circuit Diagram
The full schematic is included in the repository (PDF + KiCad source).

How It Works

•	L and R audio channels are combined into mono through current-limiting resistors.

•	The audio signal is amplified by the LM386.

•	Output is filtered and sent to a single 8Ω speaker.

Usage

1.	Connect any AUX device (phone, PC, MP3).

2.	Power the circuit with 8V DC.

3.	Adjust the volume using the potentiometer.
4.	Enjoy the amplified audio output.

