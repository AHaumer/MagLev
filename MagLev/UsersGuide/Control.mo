within MagLev.UsersGuide;
class Control "Control of the system"
  extends Modelica.Icons.Information;
  annotation (preferredView="info",Documentation(info="<html>
<p>
The system is controlled by cascaded control:
</p>
<ul>
<li>Control of the coil's current by a PI-controller according to the absolute optimum</li>
<li>Control of the magnet's velocity by a PI-controller according to the symmetric optimum</li>
<li>Control of the magnet's position by a P -controller</li>
</ul>
<p>
Note that there are other solutions for the control problem. 
However, cascaded control has proven to provide a simple and stable solution for teaching. 
</p>
<p>
Note that it is necessary to calculate the magnet's position from the output of the hall effect sensor, correcting the influence of the (known) current.
Additionally it is necessary to calculate the magnet's velocity (some sort of observer), 
and to calculate the reference current from reference force utilizing actual position 
as well as the force limits depending on actual position of the magnet for the speed controller.
</p>
<h4>Discrete control</h4>
<p>
As long as the samplePeriod of the discrete control is small compared to the time constants of the system, 
and the delay caused by the time discrete AD/DA (sample and hold) are taken into account, 
the time discrete controllers can be implemented and parameterized exactly like time continuous controllers.
</p>
<p>
It is important that all control blocks are executed within the same time schedule, i.e. with the same samplePeriod, and in the correct sequence:
</p>
<ol>
<li>AD/DA delivers measured values to the controllers and holds the output of the current controller until the next communication time instant.<br>
    PWM of the DC/DC-converter is synchronized with the AD/DA, i.e. starts at the same time instants.</li>
<li>Position controller delivers reference speed</li>
<li>Speed controller delivers reference force resp. current</li>
<li>Current controller</li>
</ol>
<p>
Two versions are implemented:
</p>
<ul>
<li>Discrete: the control tasks use the same samplePeriod, but are started slightly shifted in time.</li>
<li>Clocked: the control tasks use the same <b>Clock</b> and rely that the correct sequence is determined by the causality of the signals.</li>
</ul>
<p>
In both versions usage of algorithm keeps the sequence of commands in the desired order withon one block. 
The tool is supposed to sort the algorithm sections of the blocks according to the causiality of the signals.
</p>
<p>
Note that the synchronization of the control tasks with the pwm of the DC/DC-converter is managed by using the same samplePeriod (and the correct startTime).
</p>
</html>"));
end Control;
