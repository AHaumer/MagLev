within MagLev.Components;
block HallSensor "Hall sensor"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Voltage alfa=2.48 "Coefficient 1 (constant)";
  parameter Real beta(unit="V.m2")=2.92E-4 "Coefficient 2  (distance)";
  parameter SI.Resistance gamma=0.48 "Coefficient 3 (current)";
  parameter SI.Voltage eNoise "Noise on hall sensor output";
  parameter SI.Time samplePeriod "Sample period for noise = 1/switching frequency";
  Modelica.Blocks.Interfaces.RealInput i(quantity="Current", unit="A") annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealInput d(quantity="Position", unit="m") annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  Modelica.Blocks.Interfaces.RealOutput e(quantity="Voltage", unit="V") annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  inner Modelica.Blocks.Noise.GlobalSeed globalSeed(useAutomaticSeed=true) annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Noise.UniformNoise uniformNoise(
    samplePeriod=samplePeriod,
    y_min=-eNoise/2,
    y_max=eNoise/2)                               annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  EvaluateHallSensor evaluateHallSensor(
    alfa=alfa,
    beta=beta,
    gamma=gamma) annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
equation
  connect(add.y, e) annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  connect(uniformNoise.y, add.u1) annotation (Line(points={{41,20},{50,20},{50,6},{58,6}},color={0,0,127}));
  connect(evaluateHallSensor.y, add.u2) annotation (Line(points={{41,-20},{50,-20},{50,-6},{58,-6}}, color={0,0,127}));
  connect(d, evaluateHallSensor.u1) annotation (Line(points={{-120,0},{0,0},{0,-14},{18,-14}}, color={0,0,127}));
  connect(i, evaluateHallSensor.u2) annotation (Line(points={{0,-120},{0,-26},{18,-26}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Calculates the output signal of the Hall effect sensor, taking noise into account.
</p>
</html>"), Icon(graphics={
        Rectangle(
          extent={{-40,80},{40,0}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Sphere),
        Line(
          points={{-40,0},{-40,-60}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{0,0},{0,-60}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{40,0},{40,-60}},
          color={0,0,0},
          thickness=0.5)}));
end HallSensor;
