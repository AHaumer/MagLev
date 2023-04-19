within MagLev.Control.Continuous;
block E2d "Calculate position from hall sensor signal"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Time Tds(min=100*Modelica.Constants.eps, start=0.1) "Dead time at sample";
  parameter SI.Time Td(min=Modelica.Constants.small) "Derivative time constant > 0";
  extends MagLev.Control.BaseBlocks.E2d;
  Modelica.Blocks.Continuous.Derivative dt1(
    k=1,
    T=Td,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{60,50},{80,70}})));
  InvertHallSensor invertHallSensor(
    alfa=alfa,
    beta=beta,
    gamma=gamma)                    annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
  Modelica.Blocks.Continuous.FirstOrder sample1(
    k=1,
    T=Tds,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=i0)                                      annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Continuous.FirstOrder sample2(
    k=1,
    T=Tds,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=e0)                                      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(dt1.y, d_der) annotation (Line(points={{81,60},{92,60},{92,60},{110,60}}, color={0,0,127}));
  connect(invertHallSensor.d, d) annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
  connect(invertHallSensor.d, dt1.u) annotation (Line(points={{11,0},{40,0},{40,60},{58,60}}, color={0,0,127}));
  connect(e, sample2.u) annotation (Line(points={{-120,0},{-82,0}}, color={0,0,127}));
  connect(i, sample1.u) annotation (Line(points={{-120,60},{-82,60}}, color={0,0,127}));
  connect(sample2.y, invertHallSensor.e) annotation (Line(points={{-59,0},{-12,0}}, color={0,0,127}));
  connect(sample1.y, invertHallSensor.i) annotation (Line(points={{-59,60},{0,60},{0,12}}, color={0,0,127}));
  annotation (                   Documentation(info="<html>
<p>
Calculates the position of the magnet from the output of the hall effect sensor, using the known current. 
Additionally, the velocity of the magnet is determined by differentiating the position.
</p>
</html>"));
end E2d;
