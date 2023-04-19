within MagLev.Control.Discrete;
block PController "Simple proportional controller"
  extends Modelica.Blocks.Interfaces.DiscreteSISO;
  extends MagLev.Control.BaseBlocks.PController;
  Modelica.Blocks.Discrete.Sampler sampler(samplePeriod=samplePeriod, startTime=startTime,
    y(start=d0))                                                                           annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(sampler.u, u) annotation (Line(points={{-62,0},{-120,0}}, color={0,0,127}));
  connect(sampler.y, feedback.u1) annotation (Line(points={{-39,0},{-8,0}}, color={0,0,127}));
  connect(gain.y, y) annotation (Line(points={{61,0},{81.5,0},{81.5,0},{110,0}}, color={0,0,127}));
end PController;
