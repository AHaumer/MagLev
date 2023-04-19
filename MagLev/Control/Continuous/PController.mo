within MagLev.Control.Continuous;
block PController "Simple proportional controller"
  extends Modelica.Blocks.Interfaces.SISO;
  extends MagLev.Control.BaseBlocks.PController;
  parameter SI.Time Tds(min=100*Modelica.Constants.eps, start=0.1) "Dead time at sample";
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    k=1,
    T=Tds,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=d0)                                      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(u, firstOrder.u) annotation (Line(points={{-120,0},{-62,0}}, color={0,0,127}));
  connect(firstOrder.y, feedback.u1) annotation (Line(points={{-39,0},{-8,0}}, color={0,0,127}));
  connect(gain.y, y) annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
end PController;
