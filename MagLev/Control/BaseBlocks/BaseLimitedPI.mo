within MagLev.Control.BaseBlocks;
partial block BaseLimitedPI "Base for limited PI-controller with anti-windup and feed-forward"
  import Modelica.Blocks.Types.Init;
  import Modelica.Constants.inf;
  Modelica.Blocks.Interfaces.RealInput u_m "Connector of measured signal"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.RealInput feedForward if useFF "Connector of feed-forward signal"
    annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealInput kFF if useFF and not useConstantKFF "Connector of feed-forward factor"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Modelica.Blocks.Interfaces.RealInput yMaxVar if not constantUpperLimit "Connector of yMax input signal"
    annotation (Placement(transformation(
        origin={120,60},
        extent={{20,-20},{-20,20}})));
  Modelica.Blocks.Interfaces.RealInput yMinVar if not constantLowerLimit and not symmetricLimits "Connector of yMin input signal"
    annotation (Placement(transformation(
        origin={120,-60},
        extent={{20,-20},{-20,20}})));
  parameter Real k(unit="1")=1 "Gain";
  parameter Boolean useI=true "PI else P"
    annotation(Evaluate=true);
  parameter SI.Time Ti(min=Modelica.Constants.small)=1 "Integral time constant (T>0 required)"
    annotation(Dialog(enable=useI));
  parameter MagLev.Types.AntiWindup antiWindup=MagLev.Types.AntiWindup.BackCalc "Anti-Windup technique"
    annotation(Dialog(enable=useI));
  parameter Boolean useFF=false "Use feed-forward?"
    annotation(Dialog(group="Feed-forward"));
  parameter Boolean useConstantKFF=true "Use constant feed-forward factor?"
    annotation(Dialog(group="Feed-forward", enable=useFF));
  parameter Real KFF(unit="1")=1 "Feed-forward gain"
    annotation(Dialog(group="Feed-forward", enable=useFF and useConstantKFF));
  parameter Boolean symmetricLimits=true "Use symmetric limits?"
    annotation(Dialog(tab="Limitation"));
  parameter Boolean constantUpperLimit=true "Use constant upper limit?"
    annotation(Dialog(tab="Limitation"));
  parameter Real yMax = inf "Upper limit of output"
    annotation(Dialog(tab="Limitation", enable=constantUpperLimit));
  parameter Boolean constantLowerLimit=true "Use constant lower limit?"
    annotation(Dialog(tab="Limitation", enable=not symmetricLimits));
  parameter Real yMin=-yMax "Lower limit of output"
    annotation(Dialog(tab="Limitation", enable=constantLowerLimit and not symmetricLimits));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation(Evaluate=true,
      Dialog(group="Initialization"));
  parameter Real x_start=0 "Initial or guess value of state"
    annotation (Dialog(group="Initialization"));
  parameter Real y_start=0 "Initial value of output"
    annotation(Dialog(enable=initType == Init.SteadyState or initType == Init.InitialOutput,
      group="Initialization"));
protected
  Modelica.Blocks.Sources.Constant zeroFF(k=0) if not useFF
    annotation (Placement(transformation(extent={{-30,-100},{-10,-80}})));
  Modelica.Blocks.Sources.Constant constantKFF(k=KFF) if not useFF or useConstantKFF
    annotation (Placement(transformation(extent={{90,-100},{70,-80}})));
  Modelica.Blocks.Sources.Constant yMaxConst(k=yMax) if constantUpperLimit
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=270,
        origin={90,40})));
  Modelica.Blocks.Sources.Constant yMinConst(k=yMin) if constantLowerLimit and not symmetricLimits
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,-40})));
  Modelica.Blocks.Math.Gain gain(k=-1) if symmetricLimits annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={54,40})));
  Modelica.Blocks.Interfaces.RealInput feedForwardInt "Connector of feed-forward signal" annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=90,
        origin={0,-90}), iconTransformation(
        extent={{-4,4},{4,-4}},
        rotation=90,
        origin={0,-90})));
  Modelica.Blocks.Interfaces.RealInput kFFInt "Connector of feed-forward factor" annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={60,-90}), iconTransformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={60,-90})));
  Modelica.Blocks.Interfaces.RealInput yMinInt "Connector of yMin input signal" annotation (Placement(transformation(extent={{94,-56},{86,-64}}), iconTransformation(extent={{94,-56},{86,-64}})));
  Modelica.Blocks.Interfaces.RealInput yMaxInt "Connector of yMax input signal" annotation (Placement(transformation(extent={{94,56},{86,64}}), iconTransformation(extent={{94,56},{86,64}})));
equation
  connect(feedForward, feedForwardInt) annotation (Line(points={{0,-120},{0,-90},{4.44089e-16,-90}}, color={0,0,127}));
  connect(kFF, kFFInt) annotation (Line(points={{60,-120},{60,-90}}, color={0,0,127}));
  connect(constantKFF.y, kFFInt) annotation (Line(points={{69,-90},{60,-90}}, color={0,0,127}));
  connect(yMinVar, yMinInt) annotation (Line(points={{120,-60},{90,-60}}, color={0,0,127}));
  connect(yMinConst.y, yMinInt) annotation (Line(points={{90,-51},{90,-60}}, color={0,0,127}));
  connect(yMaxVar, yMaxInt) annotation (Line(points={{120,60},{90,60}}, color={0,0,127}));
  connect(yMaxConst.y, yMaxInt) annotation (Line(points={{90,51},{90,60}}, color={0,0,127}));
  connect(zeroFF.y, feedForwardInt) annotation (Line(points={{-9,-90},{0,-90}}, color={0,0,127}));
  connect(yMaxInt, gain.u) annotation (Line(points={{90,60},{54,60},{54,47.2}},
                                                                              color={0,0,127}));
  connect(gain.y, yMinInt) annotation (Line(points={{54,33.4},{54,-60},{90,-60}},
                                                                                color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
        Line(visible=useI, points={{-80,-80},{-80,-20},{40.8594,66.3281},
              {60,66}},                                          color = {0,0,127}),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{0,6},{60,-56}},
          textColor={192,192,192},
          textString="PI", visible=useI),
        Text(
          extent={{0,6},{60,-56}},
          textColor={192,192,192},
          textString="P", visible=not useI),
        Line(visible=not useI, points={{-80,-80},{-80,24},{56,24}},  color = {0,0,127})}),
    Documentation(info="<html>
<p>
Proportional - Integral - controller with optional feed-forward and limitation at the output.
</p>
<p>
The feed-forward gain can either be constant or given by the optional input kFF. 
Feed-forward can be switched off.
</p>
<p>
The limits for the output can be set constant or dynamic, or the lower limit being the negative of the upper limit.
</p>
</html>"));
end BaseLimitedPI;
