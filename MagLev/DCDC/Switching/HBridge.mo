within MagLev.DCDC.Switching;
model HBridge "Model of a H-bridge"
  extends Modelica.Electrical.PowerConverters.Icons.Converter;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin1;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin2;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
  parameter Modelica.Units.SI.Resistance RonTransistor=1e-05
    "Transistor closed resistance"
    annotation(Dialog(tab="Semiconductors"));
  parameter Modelica.Units.SI.Conductance GoffTransistor=1e-05
    "Transistor opened conductance"
    annotation(Dialog(tab="Semiconductors"));
  parameter Modelica.Units.SI.Voltage VkneeTransistor=0
    "Transistor threshold voltage"
    annotation(Dialog(tab="Semiconductors"));
  parameter Modelica.Units.SI.Resistance RonDiode=1e-05
    "Diode closed resistance"
    annotation(Dialog(tab="Semiconductors"));
  parameter Modelica.Units.SI.Conductance GoffDiode=1e-05
    "Diode opened conductance"
    annotation(Dialog(tab="Semiconductors"));
  parameter Modelica.Units.SI.Voltage VkneeDiode=0 "Diode threshold voltage"
    annotation(Dialog(tab="Semiconductors"));
  extends Modelica.Electrical.PowerConverters.Interfaces.Enable.Enable(final m=1);
  Modelica.Blocks.Interfaces.BooleanInput fire_p
    "Firing signal of positive potential transistor" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.BooleanInput fire_n
    "Firing signal of negative potential transistor" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistorHS_p(
    final Ron=RonTransistor,
    final Goff=GoffTransistor,
    final Vknee=VkneeTransistor,
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,30})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diodeHS_p(
    final Ron=RonDiode,
    final Goff=GoffDiode,
    final Vknee=VkneeDiode,
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,30})));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistorLS_p(
    final Ron=RonTransistor,
    final Goff=GoffTransistor,
    final Vknee=VkneeTransistor,
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-30})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diodeLS_p(
    final Ron=RonDiode,
    final Goff=GoffDiode,
    final Vknee=VkneeDiode,
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-30})));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistorHS_n(
    final Ron=RonTransistor,
    final Goff=GoffTransistor,
    final Vknee=VkneeTransistor,
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,30})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diodeHS_n(
    final Ron=RonDiode,
    final Goff=GoffDiode,
    final Vknee=VkneeDiode,
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={80,30})));
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistorLS_n(
    final Ron=RonTransistor,
    final Goff=GoffTransistor,
    final Vknee=VkneeTransistor,
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,-30})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diodeLS_n(
    final Ron=RonDiode,
    final Goff=GoffDiode,
    final Vknee=VkneeDiode,
    final useHeatPort=useHeatPort) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={80,-30})));
  Modelica.Blocks.Logical.And andHSp
    annotation (Placement(transformation(extent={{-24,12},{-40,28}})));
  Modelica.Blocks.Logical.And andLSp
    annotation (Placement(transformation(extent={{-24,-48},{-40,-32}})));
  Modelica.Blocks.Logical.Not not_p
    annotation (Placement(transformation(extent={{-10,-44},{-18,-36}})));
  Modelica.Blocks.Logical.And andLSn
    annotation (Placement(transformation(extent={{24,-48},{40,-32}})));
  Modelica.Blocks.Logical.And andHSn
    annotation (Placement(transformation(extent={{24,12},{40,28}})));
  Modelica.Blocks.Logical.Not not_n
    annotation (Placement(transformation(extent={{10,-44},{18,-36}})));
equation
  if not useHeatPort then
    LossPower = transistorHS_p.LossPower + diodeHS_p.LossPower
              + transistorLS_p.LossPower + diodeLS_p.LossPower
              + transistorHS_n.LossPower + diodeHS_n.LossPower
              + transistorLS_n.LossPower + diodeLS_n.LossPower;
  end if;
  connect(transistorHS_p.p, diodeHS_p.n)
    annotation (Line(points={{-60,40},{-80,40}}, color={0,0,255}));
  connect(transistorHS_n.p, diodeHS_n.n)
    annotation (Line(points={{60,40},{80,40}}, color={0,0,255}));
  connect(transistorLS_n.n, diodeLS_n.p)
    annotation (Line(points={{60,-40},{80,-40}}, color={0,0,255}));
  connect(transistorLS_n.p, diodeLS_n.n)
    annotation (Line(points={{60,-20},{80,-20}}, color={0,0,255}));
  connect(transistorHS_n.n, diodeHS_n.p)
    annotation (Line(points={{60,20},{80,20}}, color={0,0,255}));
  connect(transistorLS_p.n, diodeLS_p.p)
    annotation (Line(points={{-60,-40},{-80,-40}}, color={0,0,255}));
  connect(transistorLS_p.p, diodeLS_p.n)
    annotation (Line(points={{-60,-20},{-80,-20}}, color={0,0,255}));
  connect(transistorHS_p.n, diodeHS_p.p)
    annotation (Line(points={{-60,20},{-80,20}}, color={0,0,255}));
  connect(transistorHS_p.n, transistorLS_p.p)
    annotation (Line(points={{-60,20},{-60,-20}}, color={0,0,255}));
  connect(diodeHS_p.heatPort, heatPort) annotation (Line(points={{-70,30},{
          -70,-90},{0,-90},{0,-100}},
                             color={191,0,0}));
  connect(diodeLS_p.heatPort, heatPort) annotation (Line(points={{-70,-30},
          {-70,-90},{0,-90},{0,-100}},
                                  color={191,0,0}));
  connect(transistorHS_p.heatPort, heatPort) annotation (Line(points={{-70,30},
          {-70,-90},{0,-90},{0,-100}},color={191,0,0}));
  connect(transistorLS_p.heatPort, heatPort) annotation (Line(points={{-70,-30},
          {-70,-90},{0,-90},{0,-100}}, color={191,0,0}));
  connect(transistorLS_n.heatPort, heatPort) annotation (Line(points={{70,-30},
          {70,-90},{0,-90},{0,-100}},color={191,0,0}));
  connect(transistorHS_n.heatPort, heatPort) annotation (Line(points={{70,30},
          {70,-90},{0,-90},{0,-100}},
                                  color={191,0,0}));
  connect(diodeHS_n.heatPort, heatPort) annotation (Line(points={{70,30},{
          70,-90},{0,-90},{0,-100}},
                             color={191,0,0}));
  connect(diodeLS_n.heatPort, heatPort) annotation (Line(points={{70,-30},{
          70,-90},{0,-90},{0,-100}},
                             color={191,0,0}));
  connect(dc_p1, transistorHS_p.p)
    annotation (Line(points={{-100,60},{-60,60},{-60,40}}, color={0,0,255}));
  connect(dc_n1, transistorLS_p.n) annotation (Line(points={{-100,-60},{-60,
          -60},{-60,-40}},
                      color={0,0,255}));
  connect(dc_n1, transistorLS_n.n)
    annotation (Line(points={{-100,-60},{60,-60},{60,-40}}, color={0,0,255}));
  connect(dc_p1, transistorHS_n.p)
    annotation (Line(points={{-100,60},{60,60},{60,40}}, color={0,0,255}));
  connect(transistorHS_p.n, dc_p2) annotation (Line(points={{-60,20},{-60,
          10},{100,10},{100,60}},color={0,0,255}));
  connect(transistorLS_n.p, dc_n2) annotation (Line(points={{60,-20},{60,
          -10},{100,-10},{100,-60}},color={0,0,255}));
  connect(transistorHS_n.n, transistorLS_n.p)
    annotation (Line(points={{60,20},{60,-20}}, color={0,0,255}));
  connect(transistorHS_p.fire, andHSp.y)
    annotation (Line(points={{-48,20},{-40.8,20}}, color={255,0,255}));
  connect(transistorLS_p.fire, andLSp.y)
    annotation (Line(points={{-48,-40},{-40.8,-40}}, color={255,0,255}));
  connect(andLSp.u1, not_p.y)
    annotation (Line(points={{-22.4,-40},{-18.4,-40}}, color={255,0,255}));
  connect(andLSn.y, transistorLS_n.fire)
    annotation (Line(points={{40.8,-40},{48,-40}}, color={255,0,255}));
  connect(andHSn.y, transistorHS_n.fire)
    annotation (Line(points={{40.8,20},{48,20}}, color={255,0,255}));
  connect(not_n.y, andLSn.u1)
    annotation (Line(points={{18.4,-40},{22.4,-40}}, color={255,0,255}));
  connect(enableLogic.internalEnable[1], andLSp.u2) annotation (Line(points=
         {{79,-80},{0,-80},{0,-46.4},{-22.4,-46.4}}, color={255,0,255}));
  connect(enableLogic.internalEnable[1], andLSn.u2) annotation (Line(points=
         {{79,-80},{0,-80},{0,-46.4},{22.4,-46.4}}, color={255,0,255}));
  connect(enableLogic.internalEnable[1], andHSp.u2) annotation (Line(points=
         {{79,-80},{0,-80},{0,13.6},{-22.4,13.6}}, color={255,0,255}));
  connect(enableLogic.internalEnable[1], andHSn.u2) annotation (Line(points=
         {{79,-80},{0,-80},{0,13.6},{22.4,13.6}}, color={255,0,255}));
  connect(fire_p, not_p.u) annotation (Line(points={{-60,-120},{-60,-70},{
          -4,-70},{-4,-40},{-9.2,-40}}, color={255,0,255}));
  connect(fire_p, andHSp.u1) annotation (Line(points={{-60,-120},{-60,-70},
          {-4,-70},{-4,20},{-22.4,20}}, color={255,0,255}));
  connect(fire_n, not_n.u) annotation (Line(points={{60,-120},{60,-70},{4,
          -70},{4,-40},{9.2,-40}}, color={255,0,255}));
  connect(fire_n, andHSn.u1) annotation (Line(points={{60,-120},{60,-70},{4,
          -70},{4,20},{22.4,20}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={0,0},
          rotation=90),
        Line(
          points={{-40,0},{-28,0}},
          color={255,85,170}),
        Line(
          points={{-28,20},{-28,-20}},
          color={255,85,170}),
        Line(
          points={{-20,20},{-20,-20}},
          color={255,85,170}),
        Line(
          points={{-20,4},{0,24},{0,40}},
          color={255,85,170}),
        Line(
          points={{0,-24},{10,-24},{10,24},{0,24}},
          color={255,85,170}),
        Line(
          points={{0,8},{20,8}},
          color={255,85,170}),
        Line(
          points={{10,8},{0,-8},{20,-8},{10,8}},
          color={255,85,170}),
        Line(
          points={{-4,-20},{-10,-8},{-16,-14},{-4,-20}},
          color={255,85,170}),
        Line(
          points={{-20,-4},{0,-24},{0,-40}},
          color={255,85,170}),
        Text(
          extent={{0,-50},{100,-70}},
          textColor={0,0,255},
          textString="DC out"),
        Text(
          extent={{-100,70},{0,50}},
          textColor={0,0,255},
          textString="DC in")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Flexible and clearly arranged model of a H-bridge (like e.g. the L298N).
</p>
</html>"));
end HBridge;
