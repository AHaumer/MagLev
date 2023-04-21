within MagLev.UsersGuide;
class System "Description of the system"
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
</p>
</html>"));
end System;
