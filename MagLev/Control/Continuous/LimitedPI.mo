within MagLev.Control.Continuous;
block LimitedPI "Limited PI-controller with anti-windup and feed-forward"
  extends Modelica.Blocks.Interfaces.SISO(y(start=0));
  extends BaseBlocks.LimitedPI;
  import MagLev.Types.AntiWindup;
  import Modelica.Constants.small;
  output Real x(start=0) "integrator state";
protected
  Real e "Control error";
  Real predict "Prediction of ouput without limitation";
  Real cropped "Cropped part of output";
  // time-continuois version requires iteration (algebraic loop with cropped)
equation
  e = u - u_m;
  der(x) =
    if antiWindup==AntiWindup.BackCalc then (e - cropped/kp)
    else (if cropped>small then 0 else e)/Ti;
  predict =kp*e + kp*x + kFF*ffInternal;
  y = min(max(predict, yMinInt), yMaxInt);
  cropped = predict - y;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Improved version of <a href=\"modelica://Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities.LimitedPI\">Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities.LimitedPI</a>: 
Based on <a href=\"modelica://MagLev.Control.BaseBlocks.LimitedPI\">MagLev.Control.BaseBlocks.LimitedPI</a>, the limits for the output can be set individually. 
The anti-windup measure can be choosen by the user: Clamped (i.e. stopping the integrator) or BackCalc (i.e. reducing the input of the integrator).
</p>
</html>"));
end LimitedPI;
