within MagLev.Control.Discrete;
block DiscretePI
  "Discrete PI-controller with anti-windup and feed-forward"
  extends Modelica.Blocks.Interfaces.DiscreteSISO;
  import Modelica.Constants.small;
  parameter Real kp(unit="1")=1 "Proportional gain";
  parameter SI.Time Ti(min=Modelica.Constants.small)=1 "Integral time constant (T>0 required)";
  parameter MagLev.Types.AntiWindup antiWindup=MagLev.Types.AntiWindup.BackCalc "Anti-Windup technique";
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
  Modelica.Blocks.Math.Add add1(k1=Ts/Ti, k2=1)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Math.Add3 add3_1(
    k1=kp,
    k2=kp,
    k3=kFF) annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Interfaces.RealOutput x "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=small)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
  Modelica.Blocks.Sources.Constant zero(k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,90})));
  Modelica.Blocks.Math.Add add(k1=-1/kp, k2=1)
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{10,30},{30,50}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=antiWindup ==
        MagLev.Types.AntiWindup.Clamped)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
protected
  parameter SI.Time Ts=samplePeriod "Sample period";
equation
  connect(pre_x, add1.u2) annotation (Line(points={{-120,-60},{10,-60},{10,-6},
          {18,-6}},  color={0,0,127}));
  connect(feedForward, add3_1.u3)
    annotation (Line(points={{0,-120},{0,-80},{60,-80},{60,-8},{68,-8}},
                                                      color={0,0,127}));
  connect(add1.y, add3_1.u2)
    annotation (Line(points={{41,0},{68,0}},color={0,0,127}));
  connect(u, add3_1.u1) annotation (Line(points={{-120,0},{0,0},{0,14},{60,14},
          {60,8},{68,8}},   color={0,0,127}));
  connect(add3_1.y, y)
    annotation (Line(points={{91,0},{110,0}}, color={0,0,127}));
  connect(add1.y, x) annotation (Line(points={{41,0},{50,0},{50,60},{110,60}},
        color={0,0,127}));
  connect(greaterThreshold.y, switch1.u2)
    annotation (Line(points={{-39,60},{-32,60}}, color={255,0,255}));
  connect(u, switch1.u3) annotation (Line(points={{-120,0},{-40,0},{-40,52},{-32,
          52}},     color={0,0,127}));
  connect(zero.y, switch1.u1)
    annotation (Line(points={{-40,79},{-40,68},{-32,68}}, color={0,0,127}));
  connect(u, add.u2) annotation (Line(points={{-120,0},{-40,0},{-40,14},{-32,14}},
        color={0,0,127}));
  connect(switch1.y, switch2.u1) annotation (Line(points={{-9,60},{0,60},{0,48},
          {8,48}},          color={0,0,127}));
  connect(add.y, switch2.u3) annotation (Line(points={{-9,20},{8,20},{8,32}},
                    color={0,0,127}));
  connect(switch2.y, add1.u1) annotation (Line(points={{31,40},{40,40},{40,20},{
          10,20},{10,6},{18,6}},  color={0,0,127}));
  connect(booleanConstant.y, switch2.u2)
    annotation (Line(points={{1,40},{8,40}},   color={255,0,255}));
  connect(abs1.y, greaterThreshold.u)
    annotation (Line(points={{-69,60},{-62,60}}, color={0,0,127}));
  connect(cropped, abs1.u)
    annotation (Line(points={{-120,60},{-92,60}}, color={0,0,127}));
  connect(cropped, add.u1) annotation (Line(points={{-120,60},{-98,60},{-98,26},
          {-32,26}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
A time discrete implementation (forward-Euler) of PI controller with feed-forward and anti-windup. The limiter is implemented outside this block.
</p>
</html>"));
end DiscretePI;
