within MagLev.Control.Clocked;
block Adda "AD/DA conversion"
  extends Modelica.Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
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
  Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                   sample1                                                 annotation (Placement(transformation(extent={{30,50},{10,70}})));
  Modelica.Clocked.RealSignals.Sampler.Hold
                                         hold1(y_start=v0)
                                   annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                   sample2                                                 annotation (Placement(transformation(extent={{30,-70},{10,-50}})));
  Modelica.Clocked.ClockSignals.Interfaces.ClockInput clock annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
equation
  connect(sample1.u, vSrc) annotation (Line(points={{32,60},{120,60}},                   color={0,0,127}));
  connect(hold1.y, vRef) annotation (Line(points={{-9,0},{110,0}},   color={0,0,127}));
  connect(sample1.y, vBat) annotation (Line(points={{9,60},{-110,60}},                 color={0,0,127}));
  connect(v, hold1.u) annotation (Line(points={{-120,0},{-32,0}},   color={0,0,127}));
  connect(i, sample2.y) annotation (Line(points={{-110,-60},{9,-60}}, color={0,0,127}));
  connect(sample2.u, iAct) annotation (Line(points={{32,-60},{120,-60}}, color={0,0,127}));
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
  annotation (Icon(graphics={
        Text(
          extent={{-20,-42},{20,-80}},
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
Models the AD/DA-conversion as sample-hold elements.
</p>
</html>"));
end Adda;
