within MagLev.Control.Discrete;
block E2d "Calculate position from hall sensor signal"
  extends Modelica.Blocks.Icons.DiscreteBlock;
  extends MagLev.Control.BaseBlocks.E2d;
  parameter SI.Time samplePeriod(min=100*Modelica.Constants.eps, start=0.1)
    "Sample period of component";
  parameter SI.Time startTime=0 "First sample time instant";
  Der der1(samplePeriod=samplePeriod, startTime=startTime) annotation (Placement(transformation(extent={{60,50},{80,70}})));
equation
  connect(der1.y, d_der) annotation (Line(points={{81,60},{110,60}}, color={0,0,127}));
  connect(invertHallSensor.d, der1.u) annotation (Line(points={{11,0},{40,0},{40,60},{58,60}}, color={0,0,127}));
  annotation (                   Documentation(info="<html>
<p>
Calculates the position of the magnet from the output of the hall effect sensor, using the known current. 
Additionally, the velocity of the magnet is determined by differentiating the position. 
A time discrete differentiation is used.
</p>
</html>"));
end E2d;
