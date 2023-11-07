within MagLev.FMUs;
model AveragingMagLev "System with averaging DC/DC"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Position d0=data.d0 "Initial position of magnet below coil";
  parameter SI.Velocity d_der0=0 "Initial velocity of magnet";
  Components.Coil
           coil(
    data=data,
    i(fixed=true, start=data.i0))
    annotation (Placement(transformation(extent={{10,-40},{-10,-20}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage voltageSource(V=data.Vsrc)
                                                                        annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,30})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,30})));
  DCDC.Averaging.Converter converter(fSw=data.fSw)                             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270)));
  parameter ParameterRecords.DataZeltomStd data(dNoise=0) annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Components.Magnet magnet(
    m=data.m,
    d(fixed=true, start=d0),
    d_der(fixed=true, start=d_der0))
                       annotation (Placement(transformation(extent={{-10,-60},{10,
            -40}})));
  Modelica.Blocks.Interfaces.RealInput vRef annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput vBat annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput iAct annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput e annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
equation
  connect(voltageSource.n, ground.p) annotation (Line(points={{-10,30},{-20,30}},
                                                                                color={0,0,255}));
  connect(voltageSource.n, converter.dc_n1) annotation (Line(points={{-10,30},{-10,18},{-6,18},{-6,10}},
                                    color={0,0,255}));
  connect(voltageSource.p, converter.dc_p1)
    annotation (Line(points={{10,30},{10,16},{6,16},{6,10}},color={0,0,255}));
  connect(converter.dc_n2, coil.pin_n) annotation (Line(points={{-6,-10},{-6,-20}},
                                                                                  color={0,0,255}));
  connect(converter.dc_p2, coil.pin_p) annotation (Line(points={{6,-10},{6,-20}}, color={0,0,255}));
  connect(coil.flange, magnet.flange) annotation (Line(points={{0,-40},{0,-50}},   color={0,127,0}));
  connect(vRef, converter.vRef) annotation (Line(points={{-120,0},{-12,0}}, color={0,0,127}));
  connect(converter.vBat, vBat) annotation (Line(points={{-11,6},{-40,6},{-40,60},{110,60}}, color={0,0,127}));
  connect(coil.e, e) annotation (Line(points={{-11,-30},{-40,-30},{-40,-60},{110,-60}}, color={0,0,127}));
  connect(converter.iAct, iAct) annotation (Line(points={{-11,-6},{-60,-6},{-60,80},{40,80},{40,0},{110,0}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-40,100},{40,4}},
          lineColor={0,0,127},
          fillColor={85,85,255},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{-20,10},{20,0}},
          lineColor={0,127,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,255,128}),
        Ellipse(
          extent={{-20,-40},{20,-80}},
          lineColor={0,127,0},
          fillColor={0,255,128},
          fillPattern=FillPattern.Sphere)}),
    Documentation(info="<html>
<p>
Functional Mockup Unit of the system with averaging inverter, i.e. high performance but without switching effects.
</p>
</html>"));
end AveragingMagLev;
