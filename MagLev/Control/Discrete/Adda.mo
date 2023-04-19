within MagLev.Control.Discrete;
block Adda "AD/DA conversion"
  extends Modelica.Blocks.Interfaces.DiscreteBlock;
  extends MagLev.Control.BaseBlocks.Adda(vBat(start=vBat0), i(start=i0));
  Modelica.Blocks.Discrete.Sampler sample1(samplePeriod=samplePeriod, startTime=startTime) annotation (Placement(transformation(extent={{30,50},{10,70}})));
  Modelica.Blocks.Discrete.ZeroOrderHold hold1(
    samplePeriod=samplePeriod,
    startTime=startTime,
    ySample(fixed=true, start=vRef0))
                                   annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Discrete.Sampler sample2(samplePeriod=samplePeriod, startTime=startTime) annotation (Placement(transformation(extent={{30,-70},{10,-50}})));
equation
  connect(vBat, sample1.y) annotation (Line(points={{-110,60},{9,60}}, color={0,0,127}));
  connect(sample1.u, vSrc) annotation (Line(points={{32,60},{120,60}}, color={0,0,127}));
  connect(v, hold1.u) annotation (Line(points={{-120,0},{-32,0}}, color={0,0,127}));
  connect(hold1.y, vRef) annotation (Line(points={{-9,0},{110,0}}, color={0,0,127}));
  connect(i, sample2.y) annotation (Line(points={{-110,-60},{9,-60}}, color={0,0,127}));
  connect(sample2.u, iAct) annotation (Line(points={{32,-60},{120,-60}}, color={0,0,127}));
  annotation (               Documentation(info="<html>
<p>
Models the AD/DA-conversion as sample-hold elements.
</p>
</html>"));
end Adda;
