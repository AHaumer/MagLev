within MagLev.DCDC.Switching;
model Converter "Converter including measurement and basic control"
  extends MagLev.DCDC.BaseModels.BaseConverter;
  parameter SI.Time startTime=0 "Start time";
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
    startTime=startTime,
    refType=MagLev.Types.SingleReferenceType.Triangle) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,-50})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=false)
    annotation (Placement(transformation(extent={{40,-40},{20,-20}})));
  Modelica.Blocks.Discrete.Sampler sampler(samplePeriod=1/fSw, startTime=startTime)
                                                               annotation (
      Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-46,-70})));
  Modelica.Blocks.Math.Mean mean(f=fSw)
                                 annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,-30})));
equation
  connect(pwm.fire, hBridge.fire_p) annotation (Line(points={{-6,-39},{-6,-12}}, color={255,0,255}));
  connect(v2dutyCycle.dutyCycle, pwm.dutyCycle)
    annotation (Line(points={{-20,-59},{-20,-50},{-12,-50}}, color={0,0,127}));
  connect(sampler.y, v2dutyCycle.vLim)
    annotation (Line(points={{-37.2,-70},{-32,-70}}, color={0,0,127}));
  connect(booleanConstant.y, hBridge.fire_n) annotation (Line(points={{19,-30},{6,-30},{6,-12}}, color={255,0,255}));
  connect(multiSensor1.nc, hBridge.dc_p1) annotation (Line(points={{-50,10},{-40,10},{-40,6},{-10,6}}, color={0,0,255}));
  connect(multiSensor2.pc, hBridge.dc_p2) annotation (Line(points={{50,10},{40,10},{40,6},{10,6}}, color={0,0,255}));
  connect(hBridge.dc_n1, dc_n1) annotation (Line(points={{-10,-6},{-90,-6},{-90,-60},{-100,-60}}, color={0,0,255}));
  connect(hBridge.dc_n2, dc_n2) annotation (Line(points={{10,-6},{90,-6},{90,-60},{100,-60}}, color={0,0,255}));
  connect(vRef, v2dutyCycle.v) annotation (Line(points={{0,-120},{0,-90},{-20,-90},{-20,-82}}, color={0,0,127}));
  connect(multiSensor1.v, sampler.u) annotation (Line(points={{-54,-1},{-54,-50},{-60,-50},{-60,-70},{-55.6,-70}}, color={0,0,127}));
  connect(multiSensor2.v, mean.u) annotation (Line(points={{66,-1},{66,-10},{70,-10},{70,-18}}, color={0,0,127}));
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
<p>
Converter containing the H-bridge, the measurement and the limitation of the reference voltage. 
Note that the delays of the reference voltage and the measured values are modeled outside in a separate AD/DA-model, but the limiting battery voltage is sampled in this component synchronously.
The synchronization of the reference triangle signal (and the sampling of battery voltage) and the time schedule of the AD/DA and the controllers is done by using the same startTime and samplePeriod.
</p>
</html>"));
end Converter;
