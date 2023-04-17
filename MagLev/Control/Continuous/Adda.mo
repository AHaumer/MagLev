within MagLev.Control.Continuous;
block Adda "AD/DA conversion"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Time Tds(min=100*Modelica.Constants.eps, start=0.1) "Dead time st sample";
  parameter SI.Time Tdh(min=100*Modelica.Constants.eps, start=0.1) "Dead time st hold";
  parameter SI.Voltage v0 "Initial voltage across coil";
  Modelica.Blocks.Interfaces.RealInput vSrc
    annotation (Placement(transformation(extent={{140,80},{100,120}})));
  Modelica.Blocks.Interfaces.RealInput v
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput iAct
    annotation (Placement(transformation(extent={{140,-40},{100,0}})));
  Modelica.Blocks.Interfaces.RealInput eAct
    annotation (Placement(transformation(extent={{140,-100},{100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput vBat
    annotation (Placement(transformation(extent={{-100,90},{-120,110}})));
  Modelica.Blocks.Interfaces.RealOutput vRef
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput i
    annotation (Placement(transformation(extent={{-100,-30},{-120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput e
    annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
  Modelica.Blocks.Continuous.FirstOrder sample1(
    k=1,
    T=Tds,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{30,80},{10,100}})));
  Modelica.Blocks.Continuous.FirstOrder hold1(
    k=1,
    T=Tdh,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=v0) annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Modelica.Blocks.Continuous.FirstOrder sample2(
    k=1,
    T=Tds,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{30,-30},{10,-10}})));
  Modelica.Blocks.Continuous.FirstOrder sample3(
    k=1,
    T=Tds,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{30,-90},{10,-70}})));
equation
  connect(sample1.y, vBat) annotation (Line(points={{9,90},{0,90},{0,100},{-110,100}}, color={0,0,127}));
  connect(sample1.u, vSrc) annotation (Line(points={{32,90},{40,90},{40,100},{120,100}}, color={0,0,127}));
  connect(v, hold1.u) annotation (Line(points={{-120,40},{-32,40}}, color={0,0,127}));
  connect(hold1.y, vRef) annotation (Line(points={{-9,40},{110,40}}, color={0,0,127}));
  connect(sample2.u, iAct) annotation (Line(points={{32,-20},{120,-20}}, color={0,0,127}));
  connect(sample2.y, i) annotation (Line(points={{9,-20},{-110,-20}}, color={0,0,127}));
  connect(eAct, sample3.u) annotation (Line(points={{120,-80},{32,-80}}, color={0,0,127}));
  connect(sample3.y, e) annotation (Line(points={{9,-80},{-110,-80}}, color={0,0,127}));
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
