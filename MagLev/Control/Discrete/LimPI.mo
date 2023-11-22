within MagLev.Control.Discrete;
block LimPI
  "Discrete limited PI-controller with anti-windup and feed-forward"
  extends Modelica.Blocks.Interfaces.DiscreteSISO;
  extends BaseBlocks.LimitedPI(final antiWindup=MagLev.Types.AntiWindup.BackCalc);
  parameter Real x0=0 "initial integrator state";
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold(
    samplePeriod=samplePeriod,
    startTime=startTime,
    ySample(fixed=false))
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  DiscretePI discretePI(
    samplePeriod=samplePeriod,
    startTime=startTime,
    kp=kp,
    Ti=Ti,
    kFF=kFF) annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Sources.Constant zero(k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,70})));
  DiscretePI discretePI1(
    samplePeriod=samplePeriod,
    startTime=startTime,
    kp=kp,
    Ti=Ti,
    kFF=kFF) annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Math.Feedback feedback1 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={10,30})));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter1
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Modelica.Blocks.Discrete.UnitDelay unitDelay(
    y_start=x0,
    samplePeriod=samplePeriod,
    startTime=startTime)
    annotation (Placement(transformation(extent={{0,-30},{-20,-10}})));
  Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold1(
    samplePeriod=samplePeriod,
    startTime=startTime,
    ySample(fixed=false)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-20})));
protected
  parameter SI.Time Ts=samplePeriod "Sample period";
  // avoid an algebraic loop / iteration for code on embedded controller
equation
  connect(u, feedback.u1)
    annotation (Line(points={{-120,0},{-88,0}}, color={0,0,127}));
  connect(u_m, feedback.u2) annotation (Line(points={{-60,-120},{-60,-80},{-80,-80},
          {-80,-8}}, color={0,0,127}));
  connect(feedback.y, zeroOrderHold.u)
    annotation (Line(points={{-71,0},{-62,0}}, color={0,0,127}));
  connect(zero.y, discretePI.cropped)
    annotation (Line(points={{-30,59},{-30,56},{-22,56}}, color={0,0,127}));
  connect(zeroOrderHold.y, discretePI.u) annotation (Line(points={{-39,0},{-34,0},
          {-34,50},{-22,50}}, color={0,0,127}));
  connect(zeroOrderHold.y, discretePI1.u) annotation (Line(points={{-39,0},{-34,
          0},{-34,-50},{-22,-50}}, color={0,0,127}));
  connect(discretePI.y, variableLimiter.u)
    annotation (Line(points={{1,50},{18,50}}, color={0,0,127}));
  connect(yMaxInt, variableLimiter.limit1) annotation (Line(points={{90,60},{64,
          60},{64,64},{14,64},{14,58},{18,58}}, color={0,0,127}));
  connect(yMinInt, variableLimiter.limit2) annotation (Line(points={{90,-60},{
          60,-60},{60,36},{14,36},{14,42},{18,42}},
                                                 color={0,0,127}));
  connect(discretePI.y, feedback1.u1)
    annotation (Line(points={{1,50},{10,50},{10,38}}, color={0,0,127}));
  connect(variableLimiter.y, feedback1.u2) annotation (Line(points={{41,50},{50,
          50},{50,30},{18,30}}, color={0,0,127}));
  connect(feedback1.y, discretePI1.cropped) annotation (Line(points={{10,21},{10,
          12},{-30,12},{-30,-44},{-22,-44}}, color={0,0,127}));
  connect(ffInternal, discretePI.feedForward) annotation (Line(points={{0,-90},{
          0,-70},{6,-70},{6,0},{-10,0},{-10,38}}, color={0,0,127}));
  connect(discretePI1.y, variableLimiter1.u)
    annotation (Line(points={{1,-50},{18,-50}}, color={0,0,127}));
  connect(yMinInt, yMinInt)
    annotation (Line(points={{90,-60},{90,-60}}, color={0,0,127}));
  connect(yMinInt, variableLimiter1.limit2) annotation (Line(points={{90,-60},{
          60,-60},{60,-64},{14,-64},{14,-58},{18,-58}},
                                                     color={0,0,127}));
  connect(yMaxInt, variableLimiter1.limit1) annotation (Line(points={{90,60},{64,
          60},{64,-36},{14,-36},{14,-42},{18,-42}}, color={0,0,127}));
  connect(unitDelay.y, discretePI.pre_x) annotation (Line(points={{-21,-20},{-26,
          -20},{-26,44},{-22,44}}, color={0,0,127}));
  connect(unitDelay.y, discretePI1.pre_x) annotation (Line(points={{-21,-20},{-26,
          -20},{-26,-56},{-22,-56}}, color={0,0,127}));
  connect(ffInternal, discretePI1.feedForward) annotation (Line(points={{0,-90},
          {0,-70},{-10,-70},{-10,-62}}, color={0,0,127}));
  connect(variableLimiter1.y, zeroOrderHold1.u)
    annotation (Line(points={{41,-50},{50,-50},{50,-32}}, color={0,0,127}));
  connect(zeroOrderHold1.y, y)
    annotation (Line(points={{50,-9},{50,0},{110,0}}, color={0,0,127}));
  connect(discretePI1.x, unitDelay.u) annotation (Line(points={{1,-44},{10,-44},
          {10,-20},{2,-20}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
A time discrete implementation of <a href=\"modelica://MagLev.Control.Continuous.LimitedPI\">LimitedPI</a>. 
Note that the implementation avoids an algebraic loop for the ant-windup measure that would need iteration.
</p>
</html>"));
end LimPI;
