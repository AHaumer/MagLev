within MagLev.Control.Clocked;
block Adda "AD/DA conversion"
  extends Modelica.Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
  extends MagLev.Control.BaseBlocks.Adda(vBat(start=vBat0), i(start=i0));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                   sample1                                                 annotation (Placement(transformation(extent={{30,50},{10,70}})));
  Modelica.Clocked.RealSignals.Sampler.Hold
                                         hold1(y_start=vRef0)
                                   annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                   sample2                                                 annotation (Placement(transformation(extent={{30,-70},{10,-50}})));
  Modelica.Clocked.ClockSignals.Interfaces.ClockInput clock annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
equation
  connect(clock, sample2.clock) annotation (Line(
      points={{0,-120},{0,-80},{20,-80},{20,-72}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(clock, sample1.clock) annotation (Line(
      points={{0,-120},{0,40},{20,40},{20,48}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(vBat, sample1.y) annotation (Line(points={{-110,60},{9,60}}, color={0,0,127}));
  connect(sample1.u, vSrc) annotation (Line(points={{32,60},{120,60}}, color={0,0,127}));
  connect(v, hold1.u) annotation (Line(points={{-120,0},{-76,0},{-76,0},{-32,0}}, color={0,0,127}));
  connect(hold1.y, vRef) annotation (Line(points={{-9,0},{47.5,0},{47.5,0},{110,0}}, color={0,0,127}));
  connect(i, sample2.y) annotation (Line(points={{-110,-60},{9,-60}}, color={0,0,127}));
  connect(sample2.u, iAct) annotation (Line(points={{32,-60},{120,-60}}, color={0,0,127}));
  annotation (               Documentation(info="<html>
<p>
Models the AD/DA-conversion as sample-hold elements.
</p>
</html>"));
end Adda;
