within ;
package MagLev "MagneticLevitation"
  import Modelica.Units.SI;

  annotation (preferredView="info",
    version="2.1.0",
    versionDate="2023-11-07",
    uses(Modelica(version="4.0.0")),
    Documentation(info="<html>
<p>
This is a library dealing with magnetic levitation of a permanent magnet and its control.
</p>
<p>
&copy; <a href=\"mailto:anton.haumer@oth-regensburg.de\">Anton.Haumer@OTH-Regensburg.de</a>
</p>
</html>"),
    Icon(graphics={
          Rectangle(
            extent={{-60,100},{60,0}},
            lineColor={0,0,127},
            fillColor={85,85,255},
            fillPattern=FillPattern.VerticalCylinder),
          Rectangle(
            extent={{-20,10},{20,-10}},
            lineColor={28,108,200},
            fillPattern=FillPattern.Solid,
            fillColor={0,140,72}),
        Ellipse(
          extent={{-30,-40},{30,-100}},
          lineColor={0,140,72},
          fillColor={0,255,0},
          fillPattern=FillPattern.Sphere)}));
end MagLev;
