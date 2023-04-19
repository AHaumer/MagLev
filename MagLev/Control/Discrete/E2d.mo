within MagLev.Control.Discrete;
block E2d "Calculate position from hall sensor signal"
  extends Modelica.Blocks.Interfaces.DiscreteBlock;
  extends MagLev.Control.BaseBlocks.E2d;
  Modelica.Blocks.Discrete.Sampler sampler_i(
    samplePeriod=samplePeriod,
    startTime=startTime)
                 annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  Modelica.Blocks.Discrete.Sampler sampler_e(
    samplePeriod=samplePeriod,
    startTime=startTime)
                 annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Blocks.Discrete.UnitDelay unitDelay_i(
    y_start=i0,
    samplePeriod=samplePeriod,
    startTime=startTime) annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  Modelica.Blocks.Discrete.UnitDelay unitDelay_e(
    y_start=e0,
    samplePeriod=samplePeriod,
    startTime=startTime) annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  InvertHallSensor invertHallSensor(
    alfa=alfa,
    beta=beta,
    gamma=gamma) annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
  InvertHallSensor invertHallSensor_pre(
    alfa=alfa,
    beta=beta,
    gamma=gamma) annotation (Placement(transformation(extent={{10,50},{30,30}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={50,40})));
  Modelica.Blocks.Math.Gain gain(k=1/samplePeriod) annotation (Placement(transformation(extent={{70,50},{90,70}})));
equation
  connect(i, sampler_i.u) annotation (Line(points={{-120,60},{-92,60}}, color={0,0,127}));
  connect(e, sampler_e.u) annotation (Line(points={{-120,0},{-72,0}}, color={0,0,127}));
  connect(sampler_i.y, unitDelay_i.u) annotation (Line(points={{-69,60},{-60,60},{-60,80},{-52,80}}, color={0,0,127}));
  connect(sampler_e.y, unitDelay_e.u) annotation (Line(points={{-49,0},{-40,0},{-40,40},{-32,40}}, color={0,0,127}));
  connect(sampler_e.y, invertHallSensor.e) annotation (Line(points={{-49,0},{-12,0}}, color={0,0,127}));
  connect(unitDelay_e.y, invertHallSensor_pre.e) annotation (Line(points={{-9,40},{8,40}}, color={0,0,127}));
  connect(sampler_i.y, invertHallSensor.i) annotation (Line(points={{-69,60},{0,60},{0,12}}, color={0,0,127}));
  connect(unitDelay_i.y, invertHallSensor_pre.i) annotation (Line(points={{-29,80},{20,80},{20,52}}, color={0,0,127}));
  connect(invertHallSensor.d, feedback.u1) annotation (Line(points={{11,0},{50,0},{50,32}}, color={0,0,127}));
  connect(invertHallSensor.d, d) annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
  connect(gain.y, d_der) annotation (Line(points={{91,60},{110,60}}, color={0,0,127}));
  connect(feedback.y, gain.u) annotation (Line(points={{50,49},{50,60},{68,60}}, color={0,0,127}));
  connect(invertHallSensor_pre.d, feedback.u2) annotation (Line(points={{31,40},{36.5,40},{36.5,40},{42,40}}, color={0,0,127}));
  annotation (                   Documentation(info="<html>
<p>
Calculates the position of the magnet from the output of the hall effect sensor, using the known current. 
Additionally, the velocity of the magnet is determined by differentiating the position. 
A time discrete differentiation is used.
</p>
</html>"));
end E2d;
