within MagLev.Examples.Continuous;
model PositionControl "Position controlled system"
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
  Control.Continuous.LimitedPI currentController(
    kp=data.kpI,
    x0=data.v0,
    y0=data.v0,
    Ti=data.TiI,
    constantUpperLimit=false,
    symmetricLimits=false,
    yMax=data.Vsrc,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
                     annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  DCDC.Averaging.Converter converter(fSw=data.fSw)
                                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,30})));
  parameter ParameterRecords.DataZeltomStd data(dNoise=0) annotation (Placement(transformation(extent={{10,60},{30,80}})));
  Control.F2i               f2i(k=data.k,
    iC=data.iC,
    pd=data.pd,
    iMax=data.iMax,
    useSteadyStatePosition=false,         d0=data.d0)
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Control.Continuous.LimitedPI speedController(
    kp=data.kpv,
    x0=data.f0,
    y0=data.f0,
    Ti=data.Tiv,
    constantUpperLimit=false,
    symmetricLimits=false,
    yMax=data.fMax,
    constantLowerLimit=false,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
                                                 annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Continuous.FirstOrder
                                firstOrder(
    k=1,
    T=data.Tiv,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation (Placement(transformation(extent={{-110,20},{-90,40}})));
  Control.Continuous.Adda
                        adda(Td=data.Td)              annotation (Placement(transformation(extent={{30,18},{50,38}})));
  Control.Continuous.E2d
                       e2d(
    samplePeriod=1/data.fSw,
    alfa=data.alfa,
    beta=data.beta,
    gamma=data.gamma) annotation (Placement(transformation(extent={{0,-20},{-20,0}})));
  Components.Magnet magnet(
    m=data.m,
    d(fixed=true, start=data.d0),
    d_der(fixed=true)) annotation (Placement(transformation(extent={{70,-30},{90,-10}})));
  Control.ReferencePosition referencePosition(refPos=MagLev.Types.RefPos.Trapezoid,
                                                                                offset=data.d0)
                                                                               annotation (Placement(transformation(extent={{-170,20},{-150,40}})));
  Components.Visualization visualization annotation (Placement(transformation(extent={{10,-100},{50,-20}})));
  Control.Continuous.PController positionController(Td=data.Td, kp=data.ktuneP*data.kpP) annotation (Placement(transformation(extent={{-140,20},{-120,40}})));
equation
  connect(voltageSource.n, ground.p) annotation (Line(points={{70,60},{70,50}}, color={0,0,255}));
  connect(voltageSource.n, converter.dc_n1) annotation (Line(points={{70,60},{70,50},{74,50},{74,40}}, color={0,0,255}));
  connect(voltageSource.p, converter.dc_p1) annotation (Line(points={{90,60},{90,50},{86,50},{86,40}}, color={0,0,255}));
  connect(converter.dc_n2, coil.pin_n) annotation (Line(points={{74,20},{74,10}}, color={0,0,255}));
  connect(converter.dc_p2, coil.pin_p) annotation (Line(points={{86,20},{86,10}}, color={0,0,255}));
  connect(speedController.y, f2i.u) annotation (Line(points={{-59,30},{-52,30}}, color={0,0,127}));
  connect(f2i.y, currentController.u) annotation (Line(points={{-29,30},{-22,30}}, color={0,0,127}));
  connect(firstOrder.y, speedController.u) annotation (Line(points={{-89,30},{-82,30}}, color={0,0,127}));
  connect(f2i.fMax, speedController.yMaxVar) annotation (Line(points={{-51,36},{-58,36}},                       color={0,0,127}));
  connect(adda.vRef, converter.vRef) annotation (Line(points={{51,30},{68,30}}, color={0,0,127}));
  connect(currentController.yMaxVar, adda.vBat)
    annotation (Line(points={{2,36},{29,36}}, color={0,0,127}));
  connect(currentController.y, adda.v)
    annotation (Line(points={{1,30},{28,30}}, color={0,0,127}));
  connect(adda.i, currentController.u_m) annotation (Line(points={{29,24},{10,24},{10,10},{-16,10},{-16,18}},
                                             color={0,0,127}));
  connect(adda.i, e2d.i) annotation (Line(points={{29,24},{10,24},{10,-4},{
          2,-4}}, color={0,0,127}));
  connect(adda.e, e2d.e) annotation (Line(points={{29,18},{20,18},{20,-10},
          {2,-10}}, color={0,0,127}));
  connect(e2d.d_der, speedController.u_m) annotation (Line(points={{-21,-4},{-76,-4},{-76,18}},
                              color={0,0,127}));
  connect(e2d.d, f2i.d) annotation (Line(points={{-21,-10},{-40,-10},{-40,
          18}}, color={0,0,127}));
  connect(coil.e, adda.eAct) annotation (Line(points={{69,0},{60,0},{60,18},{52,18}}, color={0,0,127}));
  connect(coil.flange, magnet.flange) annotation (Line(points={{80,-10},{80,-20}}, color={0,127,0}));
  connect(converter.vBat, adda.vSrc) annotation (Line(points={{69,36},{52,36}}, color={0,0,127}));
  connect(converter.iAct, adda.iAct) annotation (Line(points={{69,24},{52,24}}, color={0,0,127}));
  connect(e2d.d, visualization.d) annotation (Line(points={{-21,-10},{-40,-10},{-40,-60},{6,-60}},  color={0,0,127}));
  connect(f2i.fMin, speedController.yMinVar) annotation (Line(points={{-51,24},{-58,24}}, color={0,0,127}));
  connect(referencePosition.y, positionController.u) annotation (Line(points={{-149,30},{-145.5,30},{-145.5,30},{-142,30}}, color={0,0,127}));
  connect(positionController.y, firstOrder.u) annotation (Line(points={{-119,30},{-115.5,30},{-115.5,30},{-112,30}}, color={0,0,127}));
  connect(e2d.d, positionController.u_m) annotation (Line(points={{-21,-10},{-130,-10},{-130,18}}, color={0,0,127}));
  annotation (experiment(
      Interval=5e-05,
      Tolerance=1e-06),
    Diagram(coordinateSystem(extent={{-180,-100},{100,100}}), graphics={Rectangle(
          extent={{-176,48},{6,-24}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{54,72},{98,-36}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>
With position control the system can be kept stable, i.e. the magnet floating below the coil. 
It is possible to choose different reference position trajectories and check whether the magnet can follow.
</p>
</html>"));
end PositionControl;
