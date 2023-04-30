within MagLev.Examples.Continuous;
model VoltageFed "System fed by constant voltage"
  extends Modelica.Icons.Example;
  Components.Coil
           coil(
    data=data,
    i(fixed=true, start=data.i0))
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage voltageSource(V=data.Vsrc)
                                                                        annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={80,60})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,50})));
  Modelica.Blocks.Sources.Constant vRef(k=data.v0)  annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  DCDC.Averaging.Converter converter(fSw=data.fSw)                             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,30})));
  parameter ParameterRecords.DataZeltomStd data(dNoise=0) annotation (Placement(transformation(extent={{10,60},{30,80}})));
  Control.Continuous.Adda adda(
    vBat0=data.Vsrc,
    vRef0=data.v0,
    i0=data.i0,
    Tds=data.Tds,
    Tdh=data.Tdh)                                       annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Control.Continuous.E2d e2d(
    i0=data.i0,
    e0=data.e0,
    Tds=data.Tds,
    Td=0.5/data.fSw,
    alfa=data.alfa,
    beta=data.beta,
    gamma=data.gamma) annotation (Placement(transformation(extent={{40,-20},{20,0}})));
  Components.Magnet magnet(
    m=data.m,
    d(fixed=true, start=data.d0),
    d_der(fixed=true)) annotation (Placement(transformation(extent={{70,-30},{90,-10}})));
equation
  connect(voltageSource.n, ground.p) annotation (Line(points={{70,60},{70,50}}, color={0,0,255}));
  connect(voltageSource.n, converter.dc_n1) annotation (Line(points={{70,60},{70,50},{74,50},{74,40}},
                                    color={0,0,255}));
  connect(voltageSource.p, converter.dc_p1) annotation (Line(points={{90,60},{90,50},{86,50},{86,40}},
                                    color={0,0,255}));
  connect(converter.dc_n2, coil.pin_n) annotation (Line(points={{74,20},{74,10}}, color={0,0,255}));
  connect(converter.dc_p2, coil.pin_p) annotation (Line(points={{86,20},{86,10}}, color={0,0,255}));
  connect(adda.vSrc, converter.vBat)
    annotation (Line(points={{42,36},{69,36}}, color={0,0,127}));
  connect(adda.vRef, converter.vRef)
    annotation (Line(points={{41,30},{68,30}}, color={0,0,127}));
  connect(adda.iAct, converter.iAct)
    annotation (Line(points={{42,24},{69,24}}, color={0,0,127}));
  connect(coil.flange, magnet.flange) annotation (Line(points={{80,-10},{80,-20}}, color={0,127,0}));
  connect(converter.iAct, e2d.i) annotation (Line(points={{69,24},{50,24},{50,-4},{42,-4}}, color={0,0,127}));
  connect(coil.e, e2d.e) annotation (Line(points={{69,0},{60,0},{60,-10},{42,-10}}, color={0,0,127}));
  connect(vRef.y, adda.v) annotation (Line(points={{1,30},{18,30}}, color={0,0,127}));
  annotation (experiment(
      StopTime=0.1,
      Interval=5e-05,
      Tolerance=1e-06),
    Diagram(coordinateSystem(extent={{-180,-100},{100,100}}), graphics={Text(
          extent={{10,-40},{90,-50}},
          textColor={28,108,200},
          textString="instable equilibrium")}),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>
Current controlled, i.e. prescribed force: 
Note that the system is only stable under perfect conditions, initialized in an equilibrium.
</p>
</html>"));
end VoltageFed;
