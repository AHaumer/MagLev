within MagLev.Control.Clocked;
block Derivative "Approximated derivative block"
  extends Modelica.Clocked.RealSignals.Interfaces.PartialClockedSISO;
  import Modelica.Blocks.Types.Init;
  parameter Real k(unit="1")=1 "Gain";
  parameter SI.Time T(min=Modelica.Constants.small) = 0.01
    "Time constants (T>0 required; T=0 is ideal derivative block)";
  parameter Init initType=Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation(Evaluate=true,
      Dialog(group="Initialization"));
  parameter Real x_start=0 "Initial or guess value of state"
    annotation (Dialog(group="Initialization"));
  parameter Real y_start=0 "Initial value of output (= state)"
    annotation(Dialog(enable=initType == Init.InitialOutput, group=
          "Initialization"));
  output Real x(start=x_start) "State of block";
protected
  SI.Time Ts = interval(u) "Sample time";
  discrete Real y_last;
initial equation
  if initType == Init.InitialState then
    x = x_start;
  elseif initType == Init.InitialOutput then
    y_last = y_start;
  end if;
equation
  when Clock() then
    x = (previous(x) + u*Ts/T)/(1 + Ts/T);
    y_last = k*(u - x)/T;
  end when;
  y = y_last;
  annotation (
    Documentation(info="<html>
<p>
A time discrete implementation of <a href=\"modelica://Modelica.Blocks.Continuous.Derivative\">Derivative (DT1)</a>.
</p>
</html>"),
         Icon(
    coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Line(points={{-80.0,78.0},{-80.0,-90.0}},
      color={192,192,192}),
  Polygon(lineColor={192,192,192},
    fillColor={192,192,192},
    fillPattern=FillPattern.Solid,
    points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
  Line(points={{-90.0,-80.0},{82.0,-80.0}},
    color={192,192,192}),
  Polygon(lineColor={192,192,192},
    fillColor={192,192,192},
    fillPattern=FillPattern.Solid,
    points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}}),
  Line(origin = {-24.667,-27.333},
    points = {{-55.333,87.333},{-19.333,-40.667},{86.667,-52.667}},
    color = {0,0,127},
    smooth = Smooth.Bezier),
  Text(textColor={192,192,192},
    extent={{-30.0,14.0},{86.0,60.0}},
    textString="DT1"),
  Text(extent={{-150.0,-150.0},{150.0,-110.0}},
    textString="k=%k")}));
end Derivative;