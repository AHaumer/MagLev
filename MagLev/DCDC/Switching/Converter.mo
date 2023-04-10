within MagLev.DCDC.Switching;
model Converter "Converter including measurement and basic control"
  extends Modelica.Electrical.PowerConverters.Icons.Converter;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin1;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin2;
  parameter SI.Frequency fSw=5000 "Switching frequency";
  Modelica.Blocks.Interfaces.RealInput vRef annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Switching.HBridge hBridge annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
  Switching.Control.Voltage2DutyCycle v2dutyCycle(
    reciprocal=false,
    useBipolarVoltage=false,
    useConstantVoltageLimit=false,
    VLim=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-70})));
  Switching.Control.SignalPWM pwm(
    useInternalSampleHold=false,
    useConstantDutyCycle=false,
    f=fSw,
    refType=MagLev.Types.SingleReferenceType.Triangle) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,-50})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(extent={{70,-20},{50,0}})));
  Modelica.Blocks.Interfaces.RealOutput iAct annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-110})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-60,-20})));
  Modelica.Blocks.Interfaces.RealOutput vBat annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-110})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=false)
    annotation (Placement(transformation(extent={{40,-40},{20,-20}})));
  Modelica.Blocks.Discrete.Sampler sampler(samplePeriod=1/fSw) annotation (
      Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-46,-70})));
equation
  connect(hBridge.dc_p2, dc_p2) annotation (Line(points={{10,6},{80,6},{80,60},{100,60}}, color={0,0,255}));
  connect(pwm.fire, hBridge.fire_p) annotation (Line(points={{-6,-39},{-6,-12}}, color={255,0,255}));
  connect(v2dutyCycle.dutyCycle, pwm.dutyCycle)
    annotation (Line(points={{-20,-59},{-20,-50},{-12,-50}}, color={0,0,127}));
  connect(vRef, v2dutyCycle.v) annotation (Line(points={{0,-120},{0,-90},{-20,-90},{-20,-82}},
                      color={0,0,127}));
  connect(hBridge.dc_n2, currentSensor.n) annotation (Line(points={{10,-6},{50,-6},{50,-10}}, color={0,0,255}));
  connect(currentSensor.p, dc_n2) annotation (Line(points={{70,-10},{80,-10},{80,
          -60},{100,-60}}, color={0,0,255}));
  connect(currentSensor.i, iAct)
    annotation (Line(points={{60,-21},{60,-110}}, color={0,0,127}));
  connect(dc_n1, voltageSensor.n) annotation (Line(points={{-100,-60},{-80,-60},{-80,-20},{-70,-20}}, color={0,0,255}));
  connect(hBridge.dc_p1, dc_p1) annotation (Line(points={{-10,6},{-80,6},{-80,60},{-100,60}}, color={0,0,255}));
  connect(hBridge.dc_p1, voltageSensor.p) annotation (Line(points={{-10,6},{-50,6},{-50,-20}}, color={0,0,255}));
  connect(dc_n1, hBridge.dc_n1) annotation (Line(points={{-100,-60},{-80,-60},{-80,-6},{-10,-6}}, color={0,0,255}));
  connect(voltageSensor.v, vBat) annotation (Line(points={{-60,-31},{-60,-110}}, color={0,0,127}));
  connect(sampler.y, v2dutyCycle.vLim)
    annotation (Line(points={{-37.2,-70},{-32,-70}}, color={0,0,127}));
  connect(voltageSensor.v, sampler.u) annotation (Line(points={{-60,-31},{
          -60,-70},{-55.6,-70}}, color={0,0,127}));
  connect(booleanConstant.y, hBridge.fire_n) annotation (Line(points={{19,-30},{6,-30},{6,-12}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-100,70},{0,50}},
          textColor={255,0,128},
          textString="DC in"),
        Text(
          extent={{0,-50},{100,-70}},
          textColor={255,0,128},
          textString="DC out")}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<html>
<p>
Converter containing the H-bridge, the measurement and the limitation of the reference voltage. 
Note that the delays of the reference and the measured values are modeled outside in a separate AD/DA-model.
</p>
</html>"));
end Converter;
