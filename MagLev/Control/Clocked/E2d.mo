within MagLev.Control.Clocked;
block E2d "Calculate position from hall sensor signal"
  extends Modelica.Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
  extends MagLev.Control.BaseBlocks.E2d;
  parameter SI.Voltage e0 "Initial Hall effect sensor signal";
  parameter SI.Current i0 "Initial coil current";
  Modelica.Clocked.ClockSignals.Interfaces.ClockInput clock annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                   sample1                                                 annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                   sample2                                                 annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  InvertHallSensor invertHallSensor(
    alfa=alfa,
    beta=beta,
    gamma=gamma) annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
  Modelica.Clocked.RealSignals.NonPeriodic.UnitDelay unitDelay1(y_start=i0)
                                                                annotation (Placement(transformation(extent={{-52,70},{-32,90}})));
  Modelica.Clocked.RealSignals.NonPeriodic.UnitDelay unitDelay2(y_start=e0)
                                                                annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  InvertHallSensor invertHallSensor_pre(
    alfa=alfa,
    beta=beta,
    gamma=gamma) annotation (Placement(transformation(extent={{10,50},{30,30}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={40,40})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Blocks.Sources.RealExpression Ts(y=interval(sample2.y)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={50,20})));
equation
  connect(e, sample2.u) annotation (Line(points={{-120,0},{-72,0}}, color={0,0,127}));
  connect(i, sample1.u) annotation (Line(points={{-120,60},{-92,60}}, color={0,0,127}));
  connect(clock, sample2.clock) annotation (Line(
      points={{0,-120},{0,-80},{-60,-80},{-60,-12}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(clock, sample1.clock) annotation (Line(
      points={{0,-120},{0,-80},{-80,-80},{-80,48}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sample2.y, invertHallSensor.e) annotation (Line(points={{-49,0},{-12,0}}, color={0,0,127}));
  connect(sample1.y, invertHallSensor.i) annotation (Line(points={{-69,60},{0,60},{0,12}}, color={0,0,127}));
  connect(invertHallSensor.d, d) annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
  connect(sample2.y, unitDelay2.u) annotation (Line(points={{-49,0},{-40,0},{-40,40},{-32,40}}, color={0,0,127}));
  connect(sample1.y, unitDelay1.u) annotation (Line(points={{-69,60},{-60,60},{-60,80},{-54,80}}, color={0,0,127}));
  connect(unitDelay2.y, invertHallSensor_pre.e) annotation (Line(points={{-9,40},{8,40}}, color={0,0,127}));
  connect(unitDelay1.y, invertHallSensor_pre.i) annotation (Line(points={{-31,80},{20,80},{20,52}}, color={0,0,127}));
  connect(invertHallSensor_pre.d, feedback.u2) annotation (Line(points={{31,40},{32,40}}, color={0,0,127}));
  connect(invertHallSensor.d, feedback.u1) annotation (Line(points={{11,0},{40,0},{40,32}}, color={0,0,127}));
  connect(feedback.y, division.u1) annotation (Line(points={{40,49},{40,66},{58,66}}, color={0,0,127}));
  connect(division.y, d_der) annotation (Line(points={{81,60},{110,60}}, color={0,0,127}));
  connect(Ts.y, division.u2) annotation (Line(points={{50,31},{50,54},{58,54}}, color={0,0,127}));
  annotation (                   Documentation(info="<html>
<p>
Calculates the position of the magnet from the output of the hall effect sensor, using the known current. 
Additionally, the velocity of the magnet is determined by differentiating the position. 
A time discrete differentiation is used.
</p>
</html>"));
end E2d;
