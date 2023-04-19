within MagLev.Control.Continuous;
block Adda "AD/DA conversion"
  extends Modelica.Blocks.Icons.Block;
  parameter SI.Time Tds(min=100*Modelica.Constants.eps, start=0.1) "Dead time at sample";
  parameter SI.Time Tdh(min=100*Modelica.Constants.eps, start=0.1) "Dead time at hold";
  extends MagLev.Control.BaseBlocks.Adda;
  Modelica.Blocks.Continuous.FirstOrder sample1(
    k=1,
    T=Tds,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=vBat0)                                   annotation (Placement(transformation(extent={{30,50},{10,70}})));
  Modelica.Blocks.Continuous.FirstOrder hold1(
    k=1,
    T=Tdh,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=vRef0)
                annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Continuous.FirstOrder sample2(
    k=1,
    T=Tds,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=i0)                                      annotation (Placement(transformation(extent={{30,-70},{10,-50}})));
equation
  connect(sample1.y, vBat) annotation (Line(points={{9,60},{-110,60}}, color={0,0,127}));
  connect(v, hold1.u) annotation (Line(points={{-120,0},{-78,0},{-78,0},{-32,0}}, color={0,0,127}));
  connect(i, sample2.y) annotation (Line(points={{-110,-60},{9,-60}}, color={0,0,127}));
  connect(sample2.u, iAct) annotation (Line(points={{32,-60},{120,-60}}, color={0,0,127}));
  connect(hold1.y, vRef) annotation (Line(points={{-9,0},{110,0}}, color={0,0,127}));
  connect(sample1.u, vSrc) annotation (Line(points={{32,60},{120,60}}, color={0,0,127}));
  annotation (               Documentation(info="<html>
<p>
Models the time delay due to AD/DA-conversion as first order elements.
</p>
</html>"));
end Adda;
