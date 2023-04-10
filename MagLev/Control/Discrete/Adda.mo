within MagLev.Control.Discrete;
block Adda "AD/DA conversion"
  extends Modelica.Blocks.Interfaces.DiscreteBlock;
  Modelica.Blocks.Interfaces.RealInput vSrc
    annotation (Placement(transformation(extent={{140,60},{100,100}})));
  Modelica.Blocks.Interfaces.RealInput v
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput iAct
    annotation (Placement(transformation(extent={{140,-60},{100,-20}})));
  Modelica.Blocks.Interfaces.RealInput eAct
    annotation (Placement(transformation(extent={{140,-120},{100,-80}})));
  Modelica.Blocks.Interfaces.RealOutput vBat
    annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
  Modelica.Blocks.Interfaces.RealOutput vRef
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput i
    annotation (Placement(transformation(extent={{-100,-50},{-120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput e
    annotation (Placement(transformation(extent={{-100,-110},{-120,-90}})));
equation
  when {sampleTrigger, initial()} then
    vBat = vSrc;
    vRef = v;
    i = iAct;
    e = eAct;
  end when;
  annotation (Icon(graphics={
        Text(
          extent={{-10,-22},{30,-60}},
          textColor={28,108,200},
          textString="i"),
        Text(
          extent={{-30,100},{30,60}},
          textColor={28,108,200},
          textString="vBat"),
        Text(
          extent={{-30,40},{30,0}},
          textColor={28,108,200},
          textString="vRef"),
        Text(
          extent={{-10,-62},{30,-100}},
          textColor={28,108,200},
          textString="e")}), Documentation(info="<html>
<p>
Models the AD/DA-conversion as sample-hold elements.
</p>
</html>"));
end Adda;
