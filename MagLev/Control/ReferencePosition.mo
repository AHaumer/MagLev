within MagLev.Control;
block ReferencePosition "Source of reference position"
  extends Modelica.Blocks.Interfaces.SO;
  import MagLev.Types.RefPos;
  parameter RefPos refPos = MagLev.Types.RefPos.Constant;
  parameter SI.Position offset=-0.02 "Offset";
  parameter SI.Length amplitude=0.005 "Amplitude"
    annotation(Dialog(enable=refPos<>RefPos.Constant));
  parameter SI.Time startTime=if refPos==RefPos.Step then 0.5 else 0.25 "Output y = offset for time < startTime"
    annotation(Dialog(enable=refPos<>RefPos.Constant));
  parameter SI.Frequency f=2 "Frequency resp. ramp duration"
    annotation(Dialog(enable=refPos<>RefPos.Constant));
  Modelica.Blocks.Sources.Constant const(
    k=offset)
    if refPos==RefPos.Constant
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=amplitude,
    duration=0.05/f,
    offset=offset,
    startTime=startTime)
    if refPos==RefPos.Step
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=amplitude,
    f=f,
    phase=0,
    offset=offset,
    startTime=startTime)
    if refPos==RefPos.Sine
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=amplitude,
    width=50,
    period=1/f,
    nperiod=-1,
    offset=offset - amplitude/2,
    startTime=startTime)
    if refPos==RefPos.Pulse
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Blocks.Sources.SawTooth sawTooth(
    amplitude=amplitude,
    period=1/f,
    nperiod=-1,
    offset=offset - amplitude/2,
    startTime=startTime)
    if refPos==RefPos.Sawtooth
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=amplitude,
    rising=0.05/f,
    width=0.45/f,
    falling=0.05/f,
    period=1/f,
    offset=offset - amplitude/2,
    startTime=startTime)
    if refPos==RefPos.Trapezoid
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
equation
  connect(const.y, y) annotation (Line(points={{41,80},{60,80},{60,0},{110,0}}, color={0,0,127}));
  connect(y,ramp. y) annotation (Line(points={{110,0},{60,0},{60,50},{41,50}}, color={0,0,127}));
  connect(sine.y, y) annotation (Line(points={{41,20},{60,20},{60,0},{110,0}},
                                                               color={0,0,127}));
  connect(y, pulse.y) annotation (Line(points={{110,0},{60,0},{60,-10},{41,-10}}, color={0,0,127}));
  connect(y, sawTooth.y) annotation (Line(points={{110,0},{60,0},{60,-40},{41,-40}}, color={0,0,127}));
  connect(trapezoid.y, y) annotation (Line(points={{41,-70},{60,-70},{60,0},{110,0}}, color={0,0,127}));
  annotation (Icon(graphics={Text(
          extent={{-100,22},{100,-18}},
          textColor={28,108,200},
          textString="%refPos")}), Documentation(info="<html>
<p>
Define reference position:
</p>
<ul>
<li>Constant</li>
<li>Step</li>
<li>Sine</li>
<li>Pulse</li>
<li>Sawtooth</li>
<li>trapezoid</li>
</ul>
</html>"));
end ReferencePosition;
