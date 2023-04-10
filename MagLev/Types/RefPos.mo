within MagLev.Types;
type RefPos = enumeration(
    Constant "Constant",
    Step "Step/Ramp",
    Sine "Sine",
    Pulse "Pulse",
    Sawtooth "Sawtooth",
    Trapezoid "Trapezoid") "Enumeration defining the reference position trajectory";
