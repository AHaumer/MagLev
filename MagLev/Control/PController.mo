within MagLev.Control;
block PController "Simple proportional controller"
extends Modelica.Blocks.Interfaces.SISO;
  parameter Real kp(unit="1")=1 "Proportional gain";
  Modelica.Blocks.Interfaces.RealInput u_m "Connector of measured signal"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Gain gain(k=kp) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(u, feedback.u1) annotation (Line(points={{-120,0},{-8,0}}, color={0,0,127}));
  connect(feedback.u2, u_m) annotation (Line(points={{0,-8},{0,-120}}, color={0,0,127}));
  connect(feedback.y, gain.u) annotation (Line(points={{9,0},{18,0}}, color={0,0,127}));
  connect(gain.y, y) annotation (Line(points={{41,0},{110,0}}, color={0,0,127}));
  annotation (Icon(graphics={
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
        Text(
          extent={{0,6},{60,-56}},
          textColor={192,192,192},
          textString="P"),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-80,30},{80,30}},                color = {0,0,127})}));
end PController;
