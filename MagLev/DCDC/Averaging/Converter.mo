within MagLev.DCDC.Averaging;
model Converter "Converter including measurement and basic control"
  extends MagLev.DCDC.BaseModels.BaseConverter;
  parameter SI.Time Ti=1e-6 "Integral time constant of power balance controller"
    annotation(Dialog(group="Advanced"));
  HBridge hBridge annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-50})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    k=1,
    T=0.75/fSw,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Sources.Constant zero(k=0) annotation (Placement(transformation(extent={{40,-80},{20,-60}})));
equation
  connect(hBridge.vRef, variableLimiter.y) annotation (Line(points={{0,-12},{0,-39}}, color={0,0,127}));
  connect(firstOrder.y, variableLimiter.limit1) annotation (Line(points={{-19,-70},{-8,-70},{-8,-62}}, color={0,0,127}));
  connect(zero.y, variableLimiter.limit2) annotation (Line(points={{19,-70},{8,-70},{8,-62}}, color={0,0,127}));
  connect(multiSensor1.nc, hBridge.dc_p1) annotation (Line(points={{-50,10},{-40,10},{-40,6},{-10,6}}, color={0,0,255}));
  connect(multiSensor2.pc, hBridge.dc_p2) annotation (Line(points={{50,10},{40,10},{40,6},{10,6}}, color={0,0,255}));
  connect(hBridge.dc_n2, dc_n2) annotation (Line(points={{10,-6},{90,-6},{90,-60},{100,-60}}, color={0,0,255}));
  connect(hBridge.dc_n1, dc_n1) annotation (Line(points={{-10,-6},{-90,-6},{-90,-60},{-100,-60}}, color={0,0,255}));
  connect(vRef, variableLimiter.u) annotation (Line(points={{0,-120},{0,-62}}, color={0,0,127}));
  connect(multiSensor1.v, firstOrder.u) annotation (Line(points={{-54,-1},{-54,-50},{-60,-50},{-60,-70},{-42,-70}}, color={0,0,127}));
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
