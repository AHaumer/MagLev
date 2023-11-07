within MagLev.Control.Clocked;
block E2d "Calculate position from hall sensor signal"
  extends Modelica.Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
  extends MagLev.Control.BaseBlocks.E2d;
  Modelica.Clocked.ClockSignals.Interfaces.ClockInput clock annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample_e annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  InvertHallSensor invertHallSensor(
    alfa=alfa,
    beta=beta,
    gamma=gamma) annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
  Modelica.Clocked.RealSignals.NonPeriodic.UnitDelay unitDelay_i(y_start=i0) annotation (Placement(transformation(extent={{-52,70},{-32,90}})));
  Modelica.Clocked.RealSignals.NonPeriodic.UnitDelay unitDelay_e(y_start=e0) annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  InvertHallSensor invertHallSensor_pre(
    alfa=alfa,
    beta=beta,
    gamma=gamma) annotation (Placement(transformation(extent={{10,50},{30,30}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={50,40})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(extent={{70,50},{90,70}})));
  Modelica.Blocks.Sources.RealExpression Ts(y=interval(sample_e.y)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={60,20})));
equation
  connect(e, sample_e.u) annotation (Line(points={{-120,0},{-72,0}}, color={0,0,127}));
  connect(clock, sample_e.clock) annotation (Line(
      points={{0,-120},{0,-80},{-60,-80},{-60,-12}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sample_e.y, invertHallSensor.e) annotation (Line(points={{-49,0},{-12,0}}, color={0,0,127}));
  connect(invertHallSensor.d, d) annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
  connect(sample_e.y, unitDelay_e.u) annotation (Line(points={{-49,0},{-40,0},{-40,40},{-32,40}}, color={0,0,127}));
  connect(unitDelay_e.y, invertHallSensor_pre.e) annotation (Line(points={{-9,40},{8,40}}, color={0,0,127}));
  connect(unitDelay_i.y, invertHallSensor_pre.i) annotation (Line(points={{-31,80},{20,80},{20,52}}, color={0,0,127}));
  connect(invertHallSensor_pre.d, feedback.u2) annotation (Line(points={{31,40},{42,40}}, color={0,0,127}));
  connect(invertHallSensor.d, feedback.u1) annotation (Line(points={{11,0},{50,0},{50,32}}, color={0,0,127}));
  connect(feedback.y, division.u1) annotation (Line(points={{50,49},{50,66},{68,66}}, color={0,0,127}));
  connect(division.y, d_der) annotation (Line(points={{91,60},{110,60}}, color={0,0,127}));
  connect(Ts.y, division.u2) annotation (Line(points={{60,31},{60,54},{68,54}}, color={0,0,127}));
  connect(i, invertHallSensor.i)
    annotation (Line(points={{-120,60},{0,60},{0,12}}, color={0,0,127}));
  connect(i, unitDelay_i.u) annotation (Line(points={{-120,60},{-60,60},{-60,80},
          {-54,80}}, color={0,0,127}));
  annotation (                   Documentation(info="<html>
<p>
Calculates the position of the magnet from the output of the hall effect sensor, using the known current. 
Additionally, the velocity of the magnet is determined by differentiating the position. 
A time discrete differentiation is used.
</p>
</html>"));
end E2d;
