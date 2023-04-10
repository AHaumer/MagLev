within MagLev.DCDC.BaseModels;
partial model BaseConverter "Converter including measurement and basic control"
  extends Modelica.Electrical.PowerConverters.Icons.Converter;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin1;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin2;
  parameter SI.Frequency fSw=5000 "Switching frequency";
  Modelica.Blocks.Interfaces.RealInput vRef annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Electrical.Analog.Sensors.MultiSensor multiSensor2 annotation (Placement(transformation(extent={{50,0},{70,20}})));
  Modelica.Blocks.Interfaces.RealOutput iAct annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-110})));
  Modelica.Electrical.Analog.Sensors.MultiSensor multiSensor1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-60,10})));
  Modelica.Blocks.Interfaces.RealOutput vBat annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-110})));
equation
  connect(multiSensor2.i, iAct) annotation (Line(points={{54,-1},{54,-50},{60,-50},{60,-110}}, color={0,0,127}));
  connect(multiSensor2.pc, multiSensor2.pv) annotation (Line(points={{50,10},{50,20},{60,20}}, color={0,0,255}));
  connect(multiSensor2.nc, dc_p2) annotation (Line(points={{70,10},{90,10},{90,60},{100,60}}, color={0,0,255}));
  connect(multiSensor2.nv, dc_n2) annotation (Line(points={{60,0},{60,-6},{90,-6},{90,-60},{100,-60}}, color={0,0,255}));
  connect(dc_p1, multiSensor1.pc) annotation (Line(points={{-100,60},{-90,60},{-90,10},{-70,10}}, color={0,0,255}));
  connect(multiSensor1.pc, multiSensor1.pv) annotation (Line(points={{-70,10},{-70,20},{-60,20}}, color={0,0,255}));
  connect(multiSensor1.nv, dc_n1) annotation (Line(points={{-60,0},{-60,-6},{-90,-6},{-90,-60},{-100,-60}}, color={0,0,255}));
  connect(multiSensor1.v, vBat) annotation (Line(points={{-54,-1},{-54,-50},{-60,-50},{-60,-110}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<html>
<p>
Converter containing the H-bridge, the measurement and the limitation of the reference voltage. 
Note that the delays of the reference and the measured values are modeled outside in a separate AD/DA-model.
</p>
</html>"));
end BaseConverter;
