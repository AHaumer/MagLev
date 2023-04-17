within MagLev.Control.Continuous;
block E2d "Calculate position from hall sensor signal"
  extends Modelica.Blocks.Icons.Block;
  extends MagLev.Control.BaseBlocks.E2d;
  parameter SI.Time Td(min=Modelica.Constants.small) "Derivative time constant > 0";
  Modelica.Blocks.Continuous.Derivative dt1(
    k=1,
    T=Td,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{60,50},{80,70}})));
equation
  connect(dt1.y, d_der) annotation (Line(points={{81,60},{92,60},{92,60},{110,60}}, color={0,0,127}));
  connect(invertHallSensor.d, dt1.u) annotation (Line(points={{11,0},{40,0},{40,60},{58,60}}, color={0,0,127}));
  annotation (                   Documentation(info="<html>
<p>
Calculates the position of the magnet from the output of the hall effect sensor, using the known current. 
Additionally, the velocity of the magnet is determined by differentiating the position.
</p>
</html>"));
end E2d;
