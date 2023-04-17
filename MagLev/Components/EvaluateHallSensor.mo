within MagLev.Components;
block EvaluateHallSensor "Evaluate equation of Hall sensor"
  extends Modelica.Blocks.Interfaces.SI2SO(
    u1(quantity="Position", unit="m"),
    u2(quantity="Current", unit="A"),
    y(quantity="Voltage", unit="V"));
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Voltage alfa=2.48 "Coefficient 1 (constant)";
  parameter Real beta(unit="V.m2")=2.92E-4 "Coefficient 2  (distance)";
  parameter SI.Resistance gamma=0.48 "Coefficient 3 (current)";
equation
  y = alfa + beta/u1^2 + gamma*u2;
end EvaluateHallSensor;
