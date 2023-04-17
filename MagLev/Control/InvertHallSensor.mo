within MagLev.Control;
block InvertHallSensor "Invert Hall sensor equation"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Voltage alfa=2.48 "Coefficient 1 (constant)";
  parameter Real beta(unit="V.m2")=2.92E-4 "Coefficient 2  (distance)";
  parameter SI.Resistance gamma=0.48 "Coefficient 3 (current)";
  Modelica.Blocks.Interfaces.RealInput i(quantity="Current", unit="A") annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealInput e(quantity="Voltage", unit="V") annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  Modelica.Blocks.Interfaces.RealOutput d(quantity="Position", unit="m")  annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  d=-sqrt(beta/abs(e - alfa - gamma*i));
  annotation (Documentation(info="<html>
<p>
Inverts the equation of the Hall effect sensor, neglecting noise.
</p>
</html>"));
end InvertHallSensor;
