within MagLev.DCDC.Switching.Control;
model SignalPWM
  "Generates a pulse width modulated (PWM) boolean fire signal"
  extends Modelica.Electrical.PowerConverters.Icons.Control;
  import MagLev.Types.SingleReferenceType;
  parameter Boolean useInternalSampleHold=true
    "Enables internal sample-hold";
  parameter Boolean useConstantDutyCycle=true
    "Enables constant duty cycle";
  parameter Real constantDutyCycle=0 "Constant duty cycle"
    annotation (Dialog(enable=useConstantDutyCycle));
  parameter SI.Frequency f=1000 "Switching frequency";
  parameter SI.Time startTime=0 "Start time";
  parameter SingleReferenceType refType=MagLev.Types.SingleReferenceType.Sawtooth "Type of reference signal";
  parameter Boolean commonComparison=true "Common or separated comparison for fire_p and fire_n"
    annotation(choices(checkBox=true));
  Modelica.Blocks.Interfaces.RealInput dutyCycle if not
    useConstantDutyCycle "Duty cycle"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput fire "Firing PWM signal"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,110})));
  Modelica.Blocks.Interfaces.BooleanOutput notFire "Firing PWM signal"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,110})));
  Modelica.Blocks.Sources.Constant const(final k=constantDutyCycle)
 if useConstantDutyCycle
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-30})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

  Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold(
     final startTime=startTime, final samplePeriod=1/f) if useInternalSampleHold
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.SawTooth sawtooth(
    final period=1/f,
    final amplitude=1,
    final nperiod=-1,
    final offset=0,
    final startTime=startTime) if refType==SingleReferenceType.Sawtooth
    annotation (Placement(transformation(origin={20,30},   extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.Trapezoid triangle(
    rising=0.5/f,
    width=0,
    falling=0.5/f,
    final period=1/f,
    final amplitude=1,
    final nperiod=-1,
    final offset=0,
    final startTime=startTime) if refType==SingleReferenceType.Triangle
    annotation (Placement(transformation(origin={-20,30},  extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Logical.Greater greaterEqual_p annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-60,70},
        rotation=90)));
  Modelica.Blocks.Logical.Not inverse if commonComparison
    annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={0,90})));
  Modelica.Blocks.Math.Add add(final k1=-1, final k2=+1) if not commonComparison annotation (Placement(transformation(extent={{10,-10},
            {30,10}})));
  Modelica.Blocks.Sources.Constant constOne(final k=1) if not commonComparison annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  Modelica.Blocks.Logical.Greater greaterEqual_n if not commonComparison annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        origin={60,70},
        rotation=90)));
  Modelica.Blocks.Routing.RealPassThrough
                            realPassThrough
                                      if not useInternalSampleHold
    annotation (Placement(transformation(extent={{-40,-10},{-20,-30}})));
equation
  connect(const.y, limiter.u) annotation (Line(
      points={{-90,-19},{-90,0},{-82,0}},           color={0,0,127}));
  connect(dutyCycle, limiter.u) annotation (Line(
      points={{-120,0},{-82,0}}, color={0,0,127}));
  connect(limiter.y, zeroOrderHold.u) annotation (Line(
      points={{-59,0},{-42,0}}, color={0,0,127}));
  connect(constOne.y, add.u2)
    annotation (Line(points={{8.88178e-16,-19},{8.88178e-16,-6},{8,-6}},
                                                          color={0,0,127}));
  connect(add.y, greaterEqual_n.u1)
    annotation (Line(points={{31,0},{60,0},{60,58}}, color={0,0,127}));
  connect(greaterEqual_p.y, fire)
    annotation (Line(points={{-60,81},{-60,110}}, color={255,0,255}));
  connect(greaterEqual_n.y, notFire)
    annotation (Line(points={{60,81},{60,110}}, color={255,0,255}));
  connect(greaterEqual_p.y, inverse.u)
    annotation (Line(points={{-60,81},{-60,90},{-12,90}}, color={255,0,255}));
  connect(inverse.y, notFire)
    annotation (Line(points={{11,90},{60,90},{60,110}}, color={255,0,255}));
  connect(triangle.y, greaterEqual_p.u2) annotation (Line(points={{-20,41},{-20,52},
          {-52,52},{-52,58}}, color={0,0,127}));
  connect(triangle.y, greaterEqual_n.u2) annotation (Line(points={{-20,41},{-20,48},
          {52,48},{52,58}}, color={0,0,127}));
  connect(greaterEqual_n.u2, sawtooth.y) annotation (Line(points={{52,58},{52,48},
          {20,48},{20,41}}, color={0,0,127}));
  connect(greaterEqual_p.u2, sawtooth.y) annotation (Line(points={{-52,58},{-52,
          52},{20,52},{20,41}},
                            color={0,0,127}));
  connect(add.u1, greaterEqual_p.u1) annotation (Line(points={{8,6},{0,6},{0,18},
          {-60,18},{-60,58}}, color={0,0,127}));
  connect(zeroOrderHold.y, greaterEqual_p.u1) annotation (Line(points={{-19,0},{
          0,0},{0,18},{-60,18},{-60,58}}, color={0,0,127}));
  connect(limiter.y, realPassThrough.u) annotation (Line(points={{-59,0},{-50,0},{-50,-20},{-42,-20}}, color={0,0,127}));
  connect(realPassThrough.y, greaterEqual_p.u1) annotation (Line(points={{-19,-20},{-10,-20},{-10,0},{0,0},{0,18},{-60,18},{-60,58}}, color={0,0,127}));
  annotation (defaultComponentName="pwm",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),graphics={     Rectangle(visible=useInternalSampleHold,
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={223,211,169},
        borderPattern=BorderPattern.Raised,
        fillPattern=FillPattern.Solid),
                                  Line(
                points={{-100,0},{-98,0},{12,0}},
                color={0,0,255}),Line(
                points={{-60,-22},{-60,-64},{44,-64},{44,-36}},
                color={0,0,255}),Line(
                points={{-80,-16},{-80,-20},{-40,20},{-40,-20},{-36,-16}},
                color={0,0,255}),Line(
                points={{-62,0},{-76,4},{-76,-4},{-62,0}},
                color={0,0,255}),Line(
                points={{44,-36},{44,-36},{40,-50},{44,-50},{48,-50},{44,
            -36}},
                color={0,0,255}),Line(
                points={{20,-20},{22,-20},{24,-20},{24,20},{44,20},{44,-20},
            {64,-20},{64,-16}},
                color={255,0,255}),Line(
                points={{-40,-16},{-40,-20},{0,20},{0,-20},{4,-16}},
                color={0,0,255}),Line(
                points={{60,-20},{62,-20},{64,-20},{64,20},{84,20},{84,-20},
            {84,-20},{88,-20}},
                color={255,0,255})}),
    Documentation(info="<html>
<p>
Improved version of <a href=\"modelica://Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM\">Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM</a>: 
It is possible to chooas a triangular reference signal instad of a sawtooth. 
This allows to sample current at the beginning of the switching period, hitting the average of teh current with good accuracy.
</p>
</html>"));
end SignalPWM;
