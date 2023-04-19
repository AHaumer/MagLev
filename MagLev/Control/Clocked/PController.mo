within MagLev.Control.Clocked;
block PController "Simple proportional controller"
  extends Modelica.Clocked.RealSignals.Interfaces.PartialClockedSISO;
  extends MagLev.Control.BaseBlocks.PController;
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1(y(start=d0))                                    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Clocked.ClockSignals.Interfaces.ClockInput clock annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
equation
  connect(sample1.u, u) annotation (Line(points={{-62,0},{-120,0}}, color={0,0,127}));
  connect(clock, sample1.clock) annotation (Line(
      points={{-60,-120},{-60,-80},{-50,-80},{-50,-12}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sample1.y, feedback.u1) annotation (Line(points={{-39,0},{-8,0}}, color={0,0,127}));
  connect(gain.y, y) annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
end PController;
