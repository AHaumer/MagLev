within MagLev.UsersGuide;
class ReleaseNotes "Release Notes"
  extends Modelica.Icons.ReleaseNotes;
  annotation (preferredView="info",Documentation(info="<html>

<h5>Version 2.3.0, 2023-11-22 Anton Haumer</h5>
<ul>
  <li>Implemented discrete LimPI with blocks (instead of equations) with Anti-Windup = BackCalc.</li>
</ul>

<h5>Version 2.2.0, 2023-11-07 Anton Haumer</h5>
<ul>
  <li>Improved FMUs: initialization and alias variables for position and velocity of magnet</li>
</ul>

<h5>Version 2.1.0, 2023-11-07 Anton Haumer</h5>
<ul>
  <li>Block e2d (continuous, discrete and cloecked) relies on current triggered by Block adda. 
      Only the Hall sensor signal is triggered in this block.</li>
  <li>Implemented the initial condition for position and velocity the magnet in the FMUs.</li>
</ul>

<h5>Version 2.0.1, 2023-04-23 Anton Haumer</h5>
<ul>
  <li>Time discrete triggered and clocked PI controller algorithm can be outsourced to common function piStep.</li>
</ul>

<h5>Version 2.0.0, 2023-04-21 Anton Haumer</h5>
<ul>
  <li>Time discrete triggered and clocked version deliver same results.</li>
</ul>

<h5>Version 1.9.0, 2023-04-19 Anton Haumer</h5>
<ul>
  <li>Unified initialization between continuous / discrete / clocked version</li>
  <li>Unbundle AD/DA and e2d</li>
  <li>Implemented clocked version (in parallel to discrete triggered version)</li>
</ul>

<h5>Version 1.8.0, 2023-04-17 Anton Haumer</h5>
<ul>
  <li>Some improvements about dead time at sample and hold</li>
  <li>Prepared for possible usage of Clocked</li>
</ul>

<h5>Version 1.7.0, 2023-04-15 Anton Haumer</h5>
<ul>
  <li>Unambiguous sequence of tasks during switching period by time shift between the sample triggers:
      AD/DA - preFilter - speedController - currentController (leads to deadTime = 1.5/fSw)</li>
</ul>

<h5>Version 1.6.0, 2023-04-13 Anton Haumer</h5>
<ul>
  <li>Simplified and unified continuous and discrte limited PI-controller</li>
</ul>

<h5>Version 1.5.0, 2023-04-10 Anton Haumer</h5>
<ul>
  <li>Enhanced f2i: more concise determination of force limits</li>
  <li>Enhanced dc/dc converter</li>
</ul>

<h5>Version 1.4.0, 2023-04-09 Anton Haumer</h5>
<ul>
  <li>Corrected parameters</li>
  <li>More concise implementation of discrete blocks</li>
</ul>

<h5>Version 1.3.0, 2023-04-03 Anton Haumer</h5>
<ul>
  <li>Set noise=0 for continuous / averaging examples and FMUs to keep performance advantage</li>
  <li>Continuous calculation of velocity in E2D based on DT1 instead on pure der().</li>
  <li>Enhancement of force formula (take force between permanent magnet and iron core without coil current into account)</li>
</ul>

<h5>Version 1.2.0, 2023-04-02 Anton Haumer</h5>
<ul>
  <li>Added noise to hall effect sensor output (can be set to 0)</li>
</ul>

<h5>Version 1.1.0, 2023-04-02 Anton Haumer</h5>
<ul>
  <li>Added Zeltom Plus with different force formula</li>
</ul>

<h5>Version 1.0.0, 2023-03-26 Anton Haumer</h5>
<ul>
  <li>Initial release</li>
</ul>

</html>"));
end ReleaseNotes;
