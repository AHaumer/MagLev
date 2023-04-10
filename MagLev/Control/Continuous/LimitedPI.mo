within MagLev.Control.Continuous;
block LimitedPI "Limited PI-controller with anti-windup and feed-forward"
  extends Modelica.Blocks.Interfaces.SISO;
  extends BaseBlocks.BaseLimitedPI;
  import Modelica.Blocks.Types.Init;
  import MagLev.Types.AntiWindup;
  import Modelica.Constants.eps;
  output Real controlError = u - u_m "Control error (set point - measurement)";
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-80,0})));

  Modelica.Blocks.Math.Add addAntiWindup(k1=1, k2=-1/k)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Continuous.Integrator integrator(
    k=1/Ti,
    use_disable=antiWindup == AntiWindup.Clamped,
    initType=Modelica.Blocks.Types.Init.NoInit) if useI annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
  Modelica.Blocks.Math.Add3 add3(
    k1=k,
    k2=k,
    k3=1)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Math.Feedback addSat annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={40,-20})));
  Modelica.Blocks.Math.Product product annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-60})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=eps) annotation (Placement(transformation(extent={{30,-40},{10,-20}})));
protected
  Modelica.Blocks.Sources.Constant zeroI(k=0) if not useI
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
initial equation
  if initType == Init.SteadyState and useI then
    der(add3.u2) = 0;
  elseif initType == Init.InitialState and useI then
    add3.u2 = x_start;
  elseif initType == Init.InitialOutput and useI then
    add3.y = y_start;
  end if;
equation
  connect(addAntiWindup.y, integrator.u) annotation (Line(points={{-39,-10},{-32,-10}},
                           color={0,0,127}));
  connect(integrator.y, add3.u2) annotation (Line(points={{-9,-10},{-4,-10},{-4,0},{8,0}},
                      color={0,0,127}));
  connect(add3.y, variableLimiter.u)
    annotation (Line(points={{31,0},{68,0}}, color={0,0,127}));
  connect(variableLimiter.y, y)
    annotation (Line(points={{91,0},{110,0}}, color={0,0,127}));
  connect(add3.y, addSat.u1)
    annotation (Line(points={{31,0},{40,0},{40,-12}}, color={0,0,127}));
  connect(variableLimiter.y, addSat.u2) annotation (Line(points={{91,0},{96,0},{96,-20},{48,-20}},
                             color={0,0,127}));
  connect(add3.u2, zeroI.y) annotation (Line(points={{8,0},{-4,0},{-4,30},{-9,30}},
                 color={0,0,127}));
  connect(feedback.y, add3.u1) annotation (Line(points={{-71,0},{-66,0},{-66,8},{8,8}},
                   color={0,0,127}));
  connect(feedback.y, addAntiWindup.u1) annotation (Line(points={{-71,0},{-66,0},{-66,-4},{-62,-4}},
                                color={0,0,127}));
  connect(addSat.y, addAntiWindup.u2) annotation (Line(points={{40,-29},{40,-44},{-66,-44},{-66,-16},{-62,-16}},
                                               color={0,0,127}));
  connect(product.y, add3.u3)
    annotation (Line(points={{6.66134e-16,-49},{6.66134e-16,-8},{8,-8}},
                                                        color={0,0,127}));
  connect(u, feedback.u1) annotation (Line(points={{-120,0},{-88,0}}, color={0,0,127}));
  connect(u_m, feedback.u2) annotation (Line(points={{-60,-120},{-60,-80},{-80,-80},{-80,-8}}, color={0,0,127}));
  connect(feedForwardInt, product.u1) annotation (Line(points={{0,-90},{0,-80},{-6,-80},{-6,-72}}, color={0,0,127}));
  connect(kFFInt, product.u2) annotation (Line(points={{60,-90},{60,-80},{6,-80},{6,-72}}, color={0,0,127}));
  connect(yMaxInt, variableLimiter.limit1) annotation (Line(points={{90,60},{60,60},{60,8},{68,8}}, color={0,0,127}));
  connect(yMinInt, variableLimiter.limit2) annotation (Line(points={{90,-60},{60,-60},{60,-8},{68,-8}}, color={0,0,127}));
  connect(addSat.y, greaterThreshold.u) annotation (Line(points={{40,-29},{40,-30},{32,-30}}, color={0,0,127}));
  connect(greaterThreshold.y, integrator.disable) annotation (Line(points={{9,-30},{-14,-30},{-14,-22}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
        Line(visible=useI, points={{-80,-80},{-80,-20},{40.8594,66.3281},
              {60,66}},                                          color = {0,0,127}),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{0,6},{60,-56}},
          textColor={192,192,192},
          textString="PI", visible=useI),
        Text(
          extent={{0,6},{60,-56}},
          textColor={192,192,192},
          textString="P", visible=not useI),
        Line(visible=not useI, points={{-80,-80},{-80,24},{56,24}},  color = {0,0,127})}),
    Documentation(info="<html>
<p>
Improved version of <a href=\"modelica://Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities.LimitedPI\">Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities.LimitedPI</a>: 
Based on <a href=\"modelica://MagLev.Control.BaseBlocks.LimitedPI\">MagLev.Control.BaseBlocks.LimitedPI</a>, the limits for the output can be set individually. 
The anti-windup measure can be choosen by the user: Clamped (i.e. stopping the integrator) or BackCalc (i.e. reducing the input of the integrator).
</p>
</html>"));
end LimitedPI;
