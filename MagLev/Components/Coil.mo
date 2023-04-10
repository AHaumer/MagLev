within MagLev.Components;
model Coil "Coil and magnetic force"
  parameter ParameterRecords.DataZeltomStd data annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (Placement(transformation(extent={{50,90},{70,110}})));
  SI.Voltage v = pin_p.v - pin_n.v "Voltage across coil";
  SI.Current i(start=0.273748) = pin_p.i "Current through coil";
  Modelica.Blocks.Interfaces.RealOutput e(quantity="Voltage", unit="V") "Output of Hall effect sensor"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10}, {120,10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=data.R, T_ref=293.15)
                                                     annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=data.L)
                                                     annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Mechanics.Translational.Sources.Force force annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-70})));
  Modelica.Mechanics.Translational.Sensors.PositionSensor positionSensor annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-70})));
  CalcForce calcForce(k=data.k,
    iC=data.iC,                 pd=data.pd)
                                annotation (Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270)));
  HallSensor hallSensor(
    alfa=data.alfa,
    beta=data.beta,
    gamma=data.gamma,
    eNoise=data.eNoise,
    samplePeriod=1/data.fSw)
                      annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={40,0})));
equation
  assert(flange.s<data.dMax,"Magnet hit coil");
  assert(flange.s>data.dMin,"Magnet fell down");
  connect(resistor.p, pin_p) annotation (Line(points={{-40,60},{-60,60},{-60,100}}, color={0,0,255}));
  connect(resistor.n, currentSensor.p) annotation (Line(points={{-20,60},{-10,60}}, color={0,0,255}));
  connect(currentSensor.n, inductor.p) annotation (Line(points={{10,60},{20,60}}, color={0,0,255}));
  connect(inductor.n, pin_n) annotation (Line(points={{40,60},{60,60},{60,100}}, color={0,0,255}));
  connect(force.flange, flange) annotation (Line(points={{-1.77636e-15,-80},{-1.77636e-15,-89},{0,-89},{0,-100}}, color={0,127,0}));
  connect(flange, positionSensor.flange) annotation (Line(points={{0,-100},{20,-100},{20,-80}}, color={0,127,0}));
  connect(currentSensor.i, calcForce.i) annotation (Line(points={{0,49},{0,12}}, color={0,0,127}));
  connect(calcForce.f, force.f) annotation (Line(points={{0,-11},{0,-58}}, color={0,0,127}));
  connect(positionSensor.s, calcForce.d) annotation (Line(points={{20,-59},{20,0},{12,0}}, color={0,0,127}));
  connect(positionSensor.s, hallSensor.d) annotation (Line(points={{20,-59},{20,0},{28,0}}, color={0,0,127}));
  connect(currentSensor.i, hallSensor.i) annotation (Line(points={{0,49},{0,20},{40,20},{40,12}}, color={0,0,127}));
  connect(hallSensor.e, e) annotation (Line(points={{51,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-60,90},{60,-70}},
            lineColor={0,0,127},
            fillColor={85,85,255},
            fillPattern=FillPattern.VerticalCylinder),
          Rectangle(
            extent={{-20,-70},{20,-90}},
            lineColor={28,108,200},
            fillPattern=FillPattern.Solid,
            fillColor={0,140,72}),
        Text(
          extent={{-130,-20},{130,20}},
          textColor={28,108,200},
          textString="%name",
          origin={-100,0},
          rotation=90)}),                      Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Consists of resistance and inductance of the coil, calculating the force acting on the magnet dependent on distance between magnet and coil. 
This is accomplished by using a translational mechanical connector, therefore the magnet can be connected easily from outside.
Additionally, the output signal of the Hall effect sensor is calculated.
</p>
</html>"));
end Coil;
