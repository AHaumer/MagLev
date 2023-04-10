within MagLev.Control.Discrete;
block FirstOrder "First order transfer function block (= 1 pole)"
  extends Modelica.Blocks.Interfaces.DiscreteSISO(final startTime=0, y(start=y_start));
  import Modelica.Blocks.Types.Init;
  parameter Real k(unit="1")=1 "Gain";
  parameter Modelica.Units.SI.Time T(start=1) "Time Constant";
  parameter Init initType=Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3/4: initial output)" annotation(Evaluate=true,
      Dialog(group="Initialization"));
  parameter Real y_start=0 "Initial or guess value of output (= state)"
    annotation (Dialog(group="Initialization"));
initial equation
  if initType == Init.InitialState or initType == Init.InitialOutput then
    pre(y) = y_start;
  end if;
equation
  when sampleTrigger then
    y = (pre(y)*T + k*u*samplePeriod)/(T + samplePeriod);
  end when;
  annotation (
    Documentation(info="<html>
<p>
A time discrete implementation of <a href=\"modelica://Modelica.Blocks.Continuous.FirstOrder\">FirstOrder</a>.
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
  Line(origin = {-26.667,6.667},
      points = {{106.667,43.333},{-13.333,29.333},{-53.333,-86.667}},
      color = {0,0,127},
      smooth = Smooth.Bezier),
  Text(textColor={192,192,192},
    extent={{0.0,-60.0},{60.0,0.0}},
    textString="PT1"),
  Text(extent={{-150.0,-150.0},{150.0,-110.0}},
    textString="T=%T")}));
end FirstOrder;
