within MagLev.Components;
block CalcForce "Magnetic force on magnet"
  extends Modelica.Blocks.Icons.Block;
  parameter Real k(unit="N.m4/A")=17.31E-9 "Force per current and distance^pd";
  parameter SI.Current iC=0 "Equivalent current describing force between pm and iron core without coil current";
  parameter Integer pd=4 "Power of distance to calculate force";
  Modelica.Blocks.Interfaces.RealInput i(quantity="Current", unit="A") annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput d(quantity="Position", unit="m") annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealOutput f(quantity="Force", unit="N") annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  f = k*(iC + i)/(abs(d))^pd "Force on magnet";
  annotation (Documentation(info="<html>
<p>
Calculates force on the magnet dependent on coil current and distance between magnet and coil.
</p>
</html>"));
end CalcForce;
