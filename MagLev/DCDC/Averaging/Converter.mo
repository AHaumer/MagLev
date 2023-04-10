within MagLev.DCDC.Averaging;
model Converter "Converter including measurement and basic control"
  extends Modelica.Electrical.PowerConverters.Icons.Converter;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin1;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin2;
  parameter SI.Frequency fSw=5000 "Switching frequency";
  parameter SI.Time Ti=1e-6 "Integral time constant of power balance controller"
    annotation(Dialog(group="Advanced"));
  Modelica.Blocks.Interfaces.RealInput vRef annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  HBridge hBridge annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
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
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    k=1,
    T=1/fSw,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Sources.Constant zero(k=0) annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
equation
  connect(hBridge.dc_p2, dc_p2) annotation (Line(points={{10,6},{80,6},{80,60},{100,60}}, color={0,0,255}));
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
  connect(hBridge.vRef, variableLimiter.y) annotation (Line(points={{0,-12},{0,-19}}, color={0,0,127}));
  connect(vRef, variableLimiter.u) annotation (Line(points={{0,-120},{0,-42}}, color={0,0,127}));
  connect(voltageSensor.v, firstOrder.u) annotation (Line(points={{-60,-31},{-60,-50},{-42,-50}}, color={0,0,127}));
  connect(firstOrder.y, variableLimiter.limit1) annotation (Line(points={{-19,-50},{-8,-50},{-8,-42}}, color={0,0,127}));
  connect(zero.y, variableLimiter.limit2) annotation (Line(points={{19,-50},{8,-50},{8,-42}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-100,70},{0,50}},
          textColor={0,0,255},
          textString="DC in"),
        Text(
          extent={{0,-50},{100,-70}},
          textColor={0,0,255},
          textString="DC out")}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Converter containing the H-bridge, the measurement and the limitation of the reference voltage. 
Note that the delay of the reference voltage is modeled outside in a separate AD/DA-model.
</p>
</html>"));
end Converter;
