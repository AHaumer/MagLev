within MagLev.Components;
block Visualization "Visualize position of magnet below coil"
  parameter SI.Position dMin = -0.03;
  parameter SI.Position dMax = 0;
  Modelica.Blocks.Interfaces.RealInput d annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  output Integer ypos=integer(-200 + 300*(d - dMin)/(dMax-dMin)) "Aux.result for visualization";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-200},{100,200}}), graphics={
        Rectangle(
          extent={{-100,200},{100,-200}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Rectangle(
          extent={{-40,200},{40,104}},
          lineColor={0,0,127},
          fillColor={85,85,255},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{-20,110},{20,100}},
          lineColor={0,127,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,255,128}),
        Ellipse(
          extent=DynamicSelect({{-20,20},{20,-20}},{{-20,ypos+20},{20,ypos-20}}),
          lineColor={0,127,0},
          fillColor={0,255,128},
          fillPattern=FillPattern.Sphere)}),
   Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-200},{100,200}})),
    Documentation(info="<html>
<p>
The position of the magnet is visualized using DynamicSelect in the the icon layer's graphical annotations.
</p>
</html>"));
end Visualization;
