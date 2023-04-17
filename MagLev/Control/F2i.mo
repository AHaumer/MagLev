within MagLev.Control;
block F2i "Transform reference force to reference current"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Real k(unit="N.m4/A")=17.31E-9 "Force per current and distance^pd";
  parameter SI.Current iC=0 "Equivalent current describing force between pm and iron core without coil current";
  parameter Integer pd=4 "Power of distance to calculate force";
  parameter SI.Current iMax=1 "Max. current";
  parameter Boolean useSteadyStatePosition=false "Otherwise actual position";
  parameter SI.Position d0=-0.02 "Steady state position below coil";
  Modelica.Blocks.Interfaces.RealInput d "Connector of Real input signal" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealOutput fMax "Connector of Real output signal" annotation (Placement(transformation(extent={{-100,50},{-120,70}})));
  Modelica.Blocks.Interfaces.RealOutput fMin "Connector of Real output signal" annotation (Placement(transformation(extent={{-100,-70},{-120,-50}})));
equation
  y = u/k*(abs(if useSteadyStatePosition then d0 else d))^pd - iC;
  fMax = (iC + iMax)*k/(abs(if useSteadyStatePosition then d0 else d))^pd;
  fMin = iC*k/(abs(if useSteadyStatePosition then d0 else d))^pd;
  annotation (Documentation(info="<html>
<p>
Calculates reference current from reference force, either using steady-state position or actual position of magnet. 
Additionally, the maximum admissible force is calculated from the maximum admissible current.
</p>
</html>"), Icon(graphics={Text(
          extent={{-40,40},{40,-40}},
          textColor={0,0,0},
          fontName="serif",
          textStyle={TextStyle.Italic},
          textString="f - i")}));
end F2i;
