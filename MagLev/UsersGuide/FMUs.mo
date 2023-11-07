within MagLev.UsersGuide;
class FMUs "FMUs"
  extends Modelica.Icons.Information;
  annotation (preferredView="info",Documentation(info="<html>
<p>
There are two Functional Mockup Units:
</p>
<ul>
<li><b><i>Averaging</i>MagLev</b>: exported as Model Exchange to test continuous control. 
    The power electronics is modeled as a power balance without switching effects.
    Sample/Hold is intended to be simulated by equivalent first order blocks.</li>
<li><b><i>Switching</i>MagLev</b>: exported as Co-Simulation to test time discrete control. 
    The power electronics is modeled with appropriate components including switching effects.
    Sample/Hold is intended to be simulated by the communication between FMU and control in the same time grid as the control algorithm including PWM.</li>
</ul>
</html>"));
end FMUs;
