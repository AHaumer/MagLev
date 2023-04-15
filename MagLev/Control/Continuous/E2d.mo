within MagLev.Control.Continuous;
block E2d "Calculate position from hall sensor signal"
  extends Modelica.Blocks.Icons.Block;
  extends MagLev.Control.BaseBlocks.E2d;
  parameter SI.Time T(min=Modelica.Constants.small)=0.5*samplePeriod
    "Time constants (T>0 required; T=0 is ideal derivative block)";
  Modelica.Blocks.Continuous.Derivative dt1(
    k=1,
    T=T,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{60,50},{80,70}})));
equation
  connect(dt1.y, d_der) annotation (Line(points={{81,60},{92,60},{92,60},{110,60}}, color={0,0,127}));
  connect(realExpression.y, dt1.u) annotation (Line(points={{22,0},{40,0},{40,60},{58,60}}, color={0,0,127}));
  annotation (Icon(graphics={
        Text(
          extent={{-100,42},{-60,82}},
          textColor={28,108,200},
          textString="i"),
        Text(
          extent={{-100,-20},{-60,20}},
          textColor={28,108,200},
          textString="e"),
        Text(
          extent={{60,-20},{100,20}},
          textColor={28,108,200},
          textString="d"),
        Text(
          extent={{30,40},{90,80}},
          textColor={28,108,200},
          textString="d_der")}), Documentation(info="<html>
<p>
Calculates the position of the magnet from the output of the hall effect sensor, using the known current. 
Additionally, the velocity of the magnet is determined by differentiating the position.
</p>
</html>"));
end E2d;
