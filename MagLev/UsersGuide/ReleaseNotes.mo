within MagLev.UsersGuide;
class ReleaseNotes "Release Notes"
  extends Modelica.Icons.ReleaseNotes;
  annotation (preferredView="info",Documentation(info="<html>

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
