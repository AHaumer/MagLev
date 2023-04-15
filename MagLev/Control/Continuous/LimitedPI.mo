within MagLev.Control.Continuous;
block LimitedPI "Limited PI-controller with anti-windup and feed-forward"
  extends Modelica.Blocks.Interfaces.SISO;
  extends BaseBlocks.LimitedPI;
  import Modelica.Blocks.Types.Init;
  import MagLev.Types.AntiWindup;
  import Modelica.Constants.small;
  output Real e "control error";
  output Real x "integrator state";
protected
  Real preview(start=y0);
  Real cropped(start=0);
initial equation
  if initType==Init.SteadyState then
    der(x) = 0;
  elseif initType==Init.InitialState then
    x = x0;
  else //initType==Init.InitialOutput
    y = y0;
  end if;
equation
  e = u - u_m;
  der(x) =
    if antiWindup==AntiWindup.BackCalc then (e - cropped/kp)
    else (if cropped>small then 0 else e)/Ti;
  preview =kp*e + kp*x + kFF*ffInternal;
  y = min(max(preview, yMinInt), yMaxInt);
  cropped = preview - y;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Improved version of <a href=\"modelica://Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities.LimitedPI\">Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities.LimitedPI</a>: 
Based on <a href=\"modelica://MagLev.Control.BaseBlocks.LimitedPI\">MagLev.Control.BaseBlocks.LimitedPI</a>, the limits for the output can be set individually. 
The anti-windup measure can be choosen by the user: Clamped (i.e. stopping the integrator) or BackCalc (i.e. reducing the input of the integrator).
</p>
</html>"));
end LimitedPI;
