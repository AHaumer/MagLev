within MagLev.Components;
model Magnet "Permnanet magnet"
  import Modelica.Constants.g_n;
  parameter SI.Mass m=3.02E-3 "Mass of magnet";
  SI.Position d(start=-0.02) "Position of magnet below coil";
  SI.Velocity d_der(start=0) "Velocity of magnet";
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange annotation (Placement(transformation(extent={{-10,-10},{10,10}}), iconTransformation(extent={{-10,-10},{10,10}})));
equation
  d = flange.s;
  der(d) = d_der;
  der(d_der)=flange.f/m - g_n;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,127,0},
          fillColor={0,255,128},
          fillPattern=FillPattern.Sphere), Text(
          extent={{-130,-20},{130,20}},
          textColor={28,108,200},
          textString="%name",
          origin={0,-100},
          rotation=180)}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Equation of motion of the magnet under influence of gravitation and the force in the translational mechanical connector.
</p>
</html>"));
end Magnet;
