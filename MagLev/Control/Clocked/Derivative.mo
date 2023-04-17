within MagLev.Control.Clocked;
block Derivative "Approximated derivative block"
  extends Modelica.Clocked.RealSignals.Interfaces.PartialClockedSISO;
  parameter Real k(unit="1")=1 "Gain";
  parameter SI.Time T(min=Modelica.Constants.small) = 0.01
    "Time constants (T>0 required; T=0 is ideal derivative block)";
  output Real x(start=0) "State of block";
protected
  SI.Time Ts = interval(u) "Sample time";
equation
  when Clock() then
    x = (previous(x) + u*Ts/T)/(1 + Ts/T);
    y = k*(u - x)/T;
  end when;
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
