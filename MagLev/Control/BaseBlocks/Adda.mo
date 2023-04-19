within MagLev.Control.BaseBlocks;
partial block Adda "AD/DA conversion"
  parameter SI.Voltage vBat0 "Initially measured source voltage";
  parameter SI.Voltage vRef0 "Initial reference voltage to DC/DC";
  parameter SI.Current i0 "Initially measured coil current";
  Modelica.Blocks.Interfaces.RealInput vSrc
    annotation (Placement(transformation(extent={{140,40},{100,80}})));
  Modelica.Blocks.Interfaces.RealInput v
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput iAct
    annotation (Placement(transformation(extent={{140,-80},{100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput vBat
    annotation (Placement(transformation(extent={{-100,50},{-120,70}})));
  Modelica.Blocks.Interfaces.RealOutput vRef
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput i
    annotation (Placement(transformation(extent={{-100,-70},{-120,-50}})));
  annotation (Icon(graphics={
        Text(
          extent={{-20,-40},{20,-78}},
          textColor={28,108,200},
          textString="i"),
        Text(
          extent={{-30,80},{30,40}},
          textColor={28,108,200},
          textString="vBat"),
        Text(
          extent={{-30,20},{30,-20}},
          textColor={28,108,200},
          textString="vRef")}),
                             Documentation(info="<html>
<p>
Models the time delay due to AD/DA-conversion as first order elements.
</p>
</html>"));
end Adda;
