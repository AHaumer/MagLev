within MagLev.Control.BaseBlocks;
partial block LimitedPI "Base for limited PI-controller with anti-windup and feed-forward"
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
  Modelica.Blocks.Interfaces.RealInput yMaxVar if not constantUpperLimit "Connector of yMax input signal"
    annotation (Placement(transformation(
        origin={120,60},
        extent={{20,-20},{-20,20}})));
  Modelica.Blocks.Interfaces.RealInput yMinVar if not constantLowerLimit and not symmetricLimits "Connector of yMin input signal"
    annotation (Placement(transformation(
        origin={120,-60},
        extent={{20,-20},{-20,20}})));
  parameter Real kp(unit="1")=1 "Proportional gain";
  parameter SI.Time Ti(min=Modelica.Constants.small)=1 "Integral time constant (T>0 required)";
  parameter MagLev.Types.AntiWindup antiWindup=MagLev.Types.AntiWindup.BackCalc "Anti-Windup technique"
    annotation(Dialog(enable=useI));
  parameter Boolean useFF=false "Use feed-forward?"
    annotation(Dialog(group="Feed-forward"));
  parameter Real kFF(unit="1")=1 "Feed-forward gain"
    annotation(Dialog(group="Feed-forward", enable=useFF));
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

protected
  Modelica.Blocks.Sources.Constant zeroFF(k=0) if not useFF
    annotation (Placement(transformation(extent={{-30,-100},{-10,-80}})));
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
        origin={70,20})));
  Modelica.Blocks.Interfaces.RealInput ffInternal "Connector of feed-forward signal" annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=90,
        origin={0,-90}), iconTransformation(
        extent={{-4,4},{4,-4}},
        rotation=90,
        origin={0,-90})));
  Modelica.Blocks.Interfaces.RealInput yMinInt "Connector of yMin input signal" annotation (Placement(transformation(extent={{94,-56},{86,-64}}), iconTransformation(extent={{94,-56},{86,-64}})));
  Modelica.Blocks.Interfaces.RealInput yMaxInt "Connector of yMax input signal" annotation (Placement(transformation(extent={{94,56},{86,64}}), iconTransformation(extent={{94,56},{86,64}})));
equation
  connect(feedForward, ffInternal) annotation (Line(points={{0,-120},{0,-90},{4.44089e-16,-90}}, color={0,0,127}));
  connect(yMinVar, yMinInt) annotation (Line(points={{120,-60},{90,-60}}, color={0,0,127}));
  connect(yMinConst.y, yMinInt) annotation (Line(points={{90,-51},{90,-60}}, color={0,0,127}));
  connect(yMaxVar, yMaxInt) annotation (Line(points={{120,60},{90,60}}, color={0,0,127}));
  connect(yMaxConst.y, yMaxInt) annotation (Line(points={{90,51},{90,60}}, color={0,0,127}));
  connect(zeroFF.y, ffInternal) annotation (Line(points={{-9,-90},{0,-90}}, color={0,0,127}));
  connect(yMaxInt, gain.u) annotation (Line(points={{90,60},{70,60},{70,27.2}},
                                                                              color={0,0,127}));
  connect(gain.y, yMinInt) annotation (Line(points={{70,13.4},{70,-60},{90,-60}},
                                                                                color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
        Line(points={{-80,-80},{-80,-20},{60,80}},               color = {0,0,127}),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{0,6},{60,-56}},
          textColor={192,192,192},
          textString="PI")}),
    Documentation(info="<html>
<p>
Proportional - Integral - controller with optional feed-forward and limitation at the output.
</p>
<p>
Feed-forward can be switched off.
</p>
<p>
The limits for the output can be set constant or dynamic, or the lower limit being the negative of the upper limit.
</p>
</html>"));
end LimitedPI;
