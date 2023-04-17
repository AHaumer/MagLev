within MagLev.Control.Clocked;
block Der "Derivative of input (= analytic differentiations)"
  extends Modelica.Clocked.RealSignals.Interfaces.PartialClockedSISO;
protected
  SI.Time Ts = interval(u) "Sample time";
equation
  when Clock() then
    y = (u - previous(u))/Ts;
  end when;
  annotation (defaultComponentName="der1",
 Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={Text(
          extent={{-96,28},{94,-24}},
          textString="der()",
          textColor={0,0,127})}),
        Documentation(info="<html>
<p>
A time discrete implementation of <a href=\"modelica://Modelica.Blocks.Continuous.Der\">ideal der()</a>.
</p>
</html>"));
end Der;
