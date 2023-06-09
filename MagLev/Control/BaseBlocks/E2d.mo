within MagLev.Control.BaseBlocks;
partial block E2d "Calculate position from hall sensor signal"
  parameter SI.Current i0 "Initially measured coil current";
  parameter SI.Voltage e0 "Initial Hall sensor signal";
  parameter SI.Voltage alfa=2.48 "Coefficient 1 (constant)"
    annotation(Dialog(group="Hall effect sensor"));
  parameter Real beta(unit="V.m2")=2.92E-4 "Coefficient 2  (distance)"
    annotation(Dialog(group="Hall effect sensor"));
  parameter SI.Resistance gamma=0.48 "Coefficient 3 (current)"
    annotation(Dialog(group="Hall effect sensor"));
  Modelica.Blocks.Interfaces.RealInput e
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput i
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealOutput d
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput d_der
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  annotation (Icon(graphics={
        Text(
          extent={{-100,42},{-60,82}},
          textColor={28,108,200},
          textString="i"),
        Text(
          extent={{-100,-20},{-60,20}},
          textColor={28,108,200},
          textString="e"),
        Text(
          extent={{60,-20},{100,20}},
          textColor={28,108,200},
          textString="d"),
        Text(
          extent={{10,46},{90,74}},
          textColor={28,108,200},
          textString="d_der")}), Documentation(info="<html>
<p>
Calculates the position of the magnet from the output of the hall effect sensor, using the known current. 
Additionally, the velocity of the magnet is determined by differentiating the position. 
</p>
</html>"));
end E2d;
