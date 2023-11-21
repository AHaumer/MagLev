within MagLev.Control.Discrete;
block DiscretePI
  "Discrete PI-controller with anti-windup and feed-forward"
  extends Modelica.Blocks.Interfaces.DiscreteSISO;
  parameter Real kp(unit="1")=1 "Proportional gain";
  parameter SI.Time Ti(min=Modelica.Constants.small)=1 "Integral time constant (T>0 required)";
  parameter Real kFF(unit="1")=1 "Feed-forward gain";
  Modelica.Blocks.Interfaces.RealInput cropped "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput pre_x "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput feedForward
    "Connector of Real input signal" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Math.Add add(k1=-1/kp, k2=1)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Modelica.Blocks.Math.Add add1(k1=Ts/Ti, k2=1)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Math.Add3 add3_1(
    k1=kp,
    k2=kp,
    k3=kFF) annotation (Placement(transformation(extent={{10,-10},{30,10}})));
protected
  parameter SI.Time Ts=samplePeriod "Sample period";
equation
  connect(cropped, add.u1) annotation (Line(points={{-120,60},{-80,60},{-80,46},
          {-72,46}}, color={0,0,127}));
  connect(u, add.u2) annotation (Line(points={{-120,0},{-80,0},{-80,34},{-72,34}},
        color={0,0,127}));
  connect(add.y, add1.u1) annotation (Line(points={{-49,40},{-40,40},{-40,6},{
          -32,6}}, color={0,0,127}));
  connect(pre_x, add1.u2) annotation (Line(points={{-120,-60},{-40,-60},{-40,-6},
          {-32,-6}}, color={0,0,127}));
  connect(feedForward, add3_1.u3)
    annotation (Line(points={{0,-120},{0,-8},{8,-8}}, color={0,0,127}));
  connect(add1.y, add3_1.u2)
    annotation (Line(points={{-9,0},{8,0}}, color={0,0,127}));
  connect(u, add3_1.u1) annotation (Line(points={{-120,0},{-60,0},{-60,20},{0,
          20},{0,8},{8,8}}, color={0,0,127}));
  connect(add3_1.y, y)
    annotation (Line(points={{31,0},{110,0}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
A time discrete implementation (forward-Euler) of PI controller with feed-forward and anti-windup. The limiter is implemented outside this block.
</p>
</html>"));
end DiscretePI;
