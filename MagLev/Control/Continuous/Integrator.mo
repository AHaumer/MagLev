within MagLev.Control.Continuous;
block Integrator "Output the integral of the input signal with optional enable"
  import Modelica.Blocks.Types.Init;
  parameter Real k(unit="1")=1 "Integrator gain";
  parameter Boolean use_disable = false "= true, if disable port enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Init initType=Init.InitialState
    "Type of initialization (1: no init, 2: steady state, 3,4: initial output)" annotation(Evaluate=true,
      Dialog(group="Initialization"));
  parameter Real y_start=0 "Initial or guess value of output (= state)"
    annotation (Dialog(group="Initialization"));
  extends Modelica.Blocks.Interfaces.SISO(y(start=y_start));
  Modelica.Blocks.Interfaces.BooleanInput disable if use_disable "Optional connector of disable signal" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
protected
  Modelica.Blocks.Interfaces.BooleanOutput local_disable annotation(HideResult=true);
initial equation
  if initType == Init.SteadyState then
     der(y) = 0;
  elseif initType == Init.InitialState or
         initType == Init.InitialOutput then
    y = y_start;
  end if;
equation
  if use_disable then
    connect(disable, local_disable);
  else
    local_disable = false;
  end if;
  der(y) = if local_disable then 0 else k*u;
  annotation (
    Documentation(info="<html>
<p>
Improved version of <a href=\"modelica://Modelica.Blocks.Continuous.Integrator\">Modelica.Blocks.Continuous.Integrator</a>: 
added an optional disable port. As long as this port is true, the integrator is stopped / disabled (for anti-windup).
</p>
</html>"),
         Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
          Line(
            points={{-80.0,78.0},{-80.0,-90.0}},
            color={192,192,192}),
          Polygon(
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
          Line(
            points={{-90.0,-80.0},{82.0,-80.0}},
            color={192,192,192}),
          Polygon(
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}}),
          Text(
            textColor={192,192,192},
            extent={{0.0,-70.0},{60.0,-10.0}},
            textString="I"),
          Text(
            extent={{-150.0,-150.0},{150.0,-110.0}},
            textString="k=%k"),
          Line(
            points={{-80.0,-80.0},{80.0,80.0}},
            color={0,0,127}),
          Line(
            visible=use_disable,
            points={{60,-100},{60,-80}},
            color={255,0,255},
            pattern=LinePattern.Dot),
          Text(
            visible=use_disable,
            extent={{-28,-62},{94,-86}},
          textString="disable",
          textColor={0,0,0})}));
end Integrator;
