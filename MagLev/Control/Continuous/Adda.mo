within MagLev.Control.Continuous;
block Adda "AD/DA conversion"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Time Tds(min=100*Modelica.Constants.eps, start=0.1) "Dead time at sample";
  parameter SI.Time Tdh(min=100*Modelica.Constants.eps, start=0.1) "Dead time at hold";
  parameter SI.Voltage v0 "Initial voltage across coil";
  Modelica.Blocks.Interfaces.RealInput vSrc
    annotation (Placement(transformation(extent={{140,40},{100,80}})));
  Modelica.Blocks.Interfaces.RealInput v
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput iAct
    annotation (Placement(transformation(extent={{140,-80},{100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput vBat
    annotation (Placement(transformation(extent={{-100,50},{-120,70}})));
  Modelica.Blocks.Interfaces.RealOutput vRef
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput i
    annotation (Placement(transformation(extent={{-100,-70},{-120,-50}})));
  Modelica.Blocks.Continuous.FirstOrder sample1(
    k=1,
    T=Tds,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{30,50},{10,70}})));
  Modelica.Blocks.Continuous.FirstOrder hold1(
    k=1,
    T=Tdh,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=v0) annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Continuous.FirstOrder sample2(
    k=1,
    T=Tds,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{30,-70},{10,-50}})));
equation
  connect(sample1.y, vBat) annotation (Line(points={{9,60},{-110,60}},                 color={0,0,127}));
  connect(sample1.u, vSrc) annotation (Line(points={{32,60},{120,60}},                   color={0,0,127}));
  connect(v, hold1.u) annotation (Line(points={{-120,0},{-32,0}},   color={0,0,127}));
  connect(hold1.y, vRef) annotation (Line(points={{-9,0},{110,0}},   color={0,0,127}));
  connect(sample2.u, iAct) annotation (Line(points={{32,-60},{120,-60}}, color={0,0,127}));
  connect(sample2.y, i) annotation (Line(points={{9,-60},{-110,-60}}, color={0,0,127}));
  annotation (Icon(graphics={
        Text(
          extent={{-10,-42},{30,-80}},
          textColor={28,108,200},
          textString="i"),
        Text(
          extent={{-30,80},{30,40}},
          textColor={28,108,200},
          textString="vBat"),
        Text(
          extent={{-30,20},{30,-20}},
          textColor={28,108,200},
          textString="vRef")}),
                             Documentation(info="<html>
<p>
Models the time delay due to AD/DA-conversion as first order elements.
</p>
</html>"));
end Adda;
