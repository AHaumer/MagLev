within MagLev.Control.Clocked;
block E2d "Calculate position from hall sensor signal"
  extends Modelica.Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
  extends MagLev.Control.BaseBlocks.E2d;
  parameter SI.Position d0=0 "Initial position";
  Der der1(u0=d0)                                          annotation (Placement(transformation(extent={{60,50},{80,70}})));
equation
  connect(der1.y, d_der) annotation (Line(points={{81,60},{110,60}}, color={0,0,127}));
  connect(invertHallSensor.d, der1.u) annotation (Line(points={{11,0},{40,0},{40,60},{58,60}}, color={0,0,127}));
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
          extent={{30,40},{90,80}},
          textColor={28,108,200},
          textString="d_der")}), Documentation(info="<html>
<p>
Calculates the position of the magnet from the output of the hall effect sensor, using the known current. 
Additionally, the velocity of the magnet is determined by differentiating the position. 
A time discrete differentiation is used.
</p>
</html>"));
end E2d;
