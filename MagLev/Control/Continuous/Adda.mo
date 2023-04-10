within MagLev.Control.Continuous;
block Adda "AD/DA conversion"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Time samplePeriod(min=100*Modelica.Constants.eps, start=0.1)
    "Sample period of component";
  Modelica.Blocks.Interfaces.RealInput vSrc
    annotation (Placement(transformation(extent={{140,60},{100,100}})));
  Modelica.Blocks.Interfaces.RealInput v
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput iAct
    annotation (Placement(transformation(extent={{140,-60},{100,-20}})));
  Modelica.Blocks.Interfaces.RealInput eAct
    annotation (Placement(transformation(extent={{140,-120},{100,-80}})));
  Modelica.Blocks.Interfaces.RealOutput vBat
    annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
  Modelica.Blocks.Interfaces.RealOutput vRef
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput i
    annotation (Placement(transformation(extent={{-100,-50},{-120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput e
    annotation (Placement(transformation(extent={{-100,-110},{-120,-90}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(
    k=1,
    T=samplePeriod/2,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{10,70},{-10,90}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(
    k=1,
    T=samplePeriod/2,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder3(
    k=1,
    T=samplePeriod/2,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder4(
    k=1,
    T=samplePeriod/2,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{10,-100},{-10,-80}})));
equation
  connect(firstOrder1.y, vBat) annotation (Line(points={{-11,80},{-110,80}}, color={0,0,127}));
  connect(firstOrder1.u, vSrc) annotation (Line(points={{12,80},{120,80}}, color={0,0,127}));
  connect(v, firstOrder2.u) annotation (Line(points={{-120,20},{-12,20}}, color={0,0,127}));
  connect(firstOrder2.y, vRef) annotation (Line(points={{11,20},{110,20}}, color={0,0,127}));
  connect(firstOrder3.u, iAct) annotation (Line(points={{12,-40},{120,-40}}, color={0,0,127}));
  connect(firstOrder3.y, i) annotation (Line(points={{-11,-40},{-110,-40}}, color={0,0,127}));
  connect(eAct, firstOrder4.u) annotation (Line(points={{120,-100},{20,-100},{20,-90},{12,-90}}, color={0,0,127}));
  connect(firstOrder4.y, e) annotation (Line(points={{-11,-90},{-20,-90},{-20,-100},{-110,-100}}, color={0,0,127}));
  annotation (Icon(graphics={
        Text(
          extent={{-10,-22},{30,-60}},
          textColor={28,108,200},
          textString="i"),
        Text(
          extent={{-30,100},{30,60}},
          textColor={28,108,200},
          textString="vBat"),
        Text(
          extent={{-30,40},{30,0}},
          textColor={28,108,200},
          textString="vRef"),
        Text(
          extent={{-10,-62},{30,-100}},
          textColor={28,108,200},
          textString="e")}), Documentation(info="<html>
<p>
Models the time delay due to AD/DA-conversion as first order elements.
</p>
</html>"));
end Adda;
