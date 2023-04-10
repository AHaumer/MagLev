within MagLev.UsersGuide;
class Control "Control of the system"
  extends Modelica.Icons.Information;
  annotation (preferredView="info",Documentation(info="<html>
<p>
The system consists of the following components:
</p>
<ul>
<li>The coil: v = R*i + L*di/dt</li>
<li>The magnetic force on the permanent magnet: f = k*(iC + i)/abs(d)<sup>pd</sup><br>
    iC describes the force between magnet and iron core without coil current.</li>
<li>The output voltage of the hall effect sensor: e = alfa + beta/d<sup>2</sup> + gamma*i</li>
<li>The equation of motion of the magnet: f - m*g = m*dv/dt</li>
</ul>
<p>
It can be assumed that some parts of the equations as well as the coefficients were obtained by Zeltom by performing measurements.
</p>
<p>
Note that the axis of motion is vertical in the middle of the coil, directing upwards.
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
Note that high switching frequency gives quicker control but requires tuning of the position controller. 
Furthermore, high switching frequency increases noise on the magnet's velocity due to numeric differentiation.
</p>
<p>
Note that it is necessary to calculate the magnet's position from the output of the hall effect sensor, correcting the influence of the (known) current.
Additionally it is necessary to calculate the magnet's velocity (some sort of observer), 
and to calculate the reference current from reference force utilizing actual position.
</p>
</html>"));
end Control;
