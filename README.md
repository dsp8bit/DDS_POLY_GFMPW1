# Direct Digital Synthesizer based on Polynomial Approximation
By Luis Rene Vela Garcia and Sandra Mariel Martinez Loide
## Overview
The Direct Digital Synthesizer (DDS) based on the polynomial approximation technique is a module which allows to generate a periodic, discrete-time waveform. In this implementation the waveform consists in a 16-bit 2´s complement sinusoidal with configurable parameters such as frequency and phase.
## Sinusoid generation
Instead of using the classical approach of a LUT-based DDS or CORDIC-based DDS, the DDS performs the sinusoid evaluation by the piecewise polynomial approximation of the cos(2*pi*x) function. The polynomial coefficients are found using the least squares error. 
## Key Features
- **DDS module:** it generates a periodic, discrete-time sinusoid.
- **Piecewise Polynomial approximation:** The sinusoid function approximated with 32 second-degree polynomials, I.e., the cos(2*pi*x) is divided in 32 segments, each segment is evaluated with a second degree polynomial function.
- **Frequency and phase:** The frequency and phase of the sinusoid is configurable.

## Designed at CINVESTAV-IPN, Unidad Guadalajara, Mexico

This DDS generator was designed at the Center for Research and Advanced Studies of the National Polytechnic Institute (CINVESTAV-IPN), Unidad Guadalajara, Mexico.

## License

This project is licensed under the [MIT License](LICENSE).
