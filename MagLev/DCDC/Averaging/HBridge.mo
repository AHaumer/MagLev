within MagLev.DCDC.Averaging;
model HBridge "Model of a H-bridge"
  extends Modelica.Electrical.PowerConverters.Icons.Converter;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin1;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin2;
  parameter SI.Time Ti=1e-6 "Integral time constant of power balance controller";
  Modelica.Blocks.Interfaces.RealInput vRef annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,-20})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor2 annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,20})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor1 annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{40,30},{20,10}})));
  Modelica.Blocks.Continuous.Integrator integrator(k=1/Ti, initType=Modelica.Blocks.Types.Init.SteadyState)
                                                   annotation (Placement(transformation(extent={{10,10},{-10,30}})));
equation
  connect(signalVoltage.p, powerSensor2.pc) annotation (Line(points={{50,-10},{50,60},{60,60}}, color={0,0,255}));
  connect(powerSensor2.pc, powerSensor2.pv) annotation (Line(points={{60,60},{60,70},{70,70}}, color={0,0,255}));
  connect(powerSensor2.nc, dc_p2) annotation (Line(points={{80,60},{100,60}}, color={0,0,255}));
  connect(powerSensor2.nv, ground.p) annotation (Line(points={{70,50},{70,-60}}, color={0,0,255}));
  connect(signalVoltage.n, ground.p) annotation (Line(points={{50,-30},{50,-60},{70,-60}}, color={0,0,255}));
  connect(ground.p, dc_n2) annotation (Line(points={{70,-60},{100,-60}}, color={0,0,255}));
  connect(signalCurrent.n, dc_n1) annotation (Line(points={{-50,10},{-50,-60},{-100,-60}}, color={0,0,255}));
  connect(dc_p1, powerSensor1.pc) annotation (Line(points={{-100,60},{-80,60}}, color={0,0,255}));
  connect(powerSensor1.pc, powerSensor1.pv) annotation (Line(points={{-80,60},{-80,70},{-70,70}}, color={0,0,255}));
  connect(powerSensor1.nc, signalCurrent.p) annotation (Line(points={{-60,60},{-50,60},{-50,30}}, color={0,0,255}));
  connect(dc_n1, powerSensor1.nv) annotation (Line(points={{-100,-60},{-70,-60},{-70,50}}, color={0,0,255}));
  connect(powerSensor2.power, feedback.u1) annotation (Line(points={{60,49},{60,20},{38,20}}, color={0,0,127}));
  connect(powerSensor1.power, feedback.u2) annotation (Line(points={{-80,49},{-80,40},{30,40},{30,28}}, color={0,0,127}));
  connect(feedback.y, integrator.u) annotation (Line(points={{21,20},{12,20}}, color={0,0,127}));
  connect(integrator.y, signalCurrent.i) annotation (Line(points={{-11,20},{-38,20}}, color={0,0,127}));
  connect(vRef, signalVoltage.v) annotation (Line(points={{0,-120},{0,-20},{38,-20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          rotation=90),
        Text(
          extent={{0,-50},{100,-70}},
          textColor={0,0,255},
          textString="DC out"),
        Text(
          extent={{-100,70},{0,50}},
          textColor={0,0,255},
          textString="DC in"),
        Text(
          extent={{-20,20},{20,-20}},
          textColor={28,108,200},
          textString="==")}),                                    Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Flexible and clearly arranged model of a H-bridge, based on power balance.
</p>
<p>
Note that limitation of the output voltage as well as delay has to be provided externally.
</p>
</html>"));
end HBridge;
