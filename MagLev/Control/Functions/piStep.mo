within MagLev.Control.Functions;
function piStep "Performs one step of a time-discrete limited PI-control algorithm"
  extends Modelica.Icons.Function;
  import MagLev.Types.AntiWindup;
  import Modelica.Constants.small;
  input Real u "Reference signal";
  input Real u_m "Measured signal";
  input Real kp "Parameter proportional gain";
  input SI.Time Ti "Parameter integral time constant";
  input SI.Time Ts "Sample period";
  input Real kFF "Parameter proportional gain of feed-forward";
  input Real ff "Feed-forward signal";
  input AntiWindup antiWindup "Anti-Windup measure";
  input Real yMin "Lower limit of output";
  input Real yMax "Upper limit of output";
  input Real pre_x "Previous state";
  output Real x "State";
  output Real y "Result";
protected
  Real e "Control error";
  Real predict "Prediction of ouput without limitation";
  Real cropped "Cropped part of output";
algorithm
  e := u - u_m;
  predict := kp*e + kp*(pre_x + Ts/Ti*e) + kFF*ff;
  cropped := predict - min(max(predict, yMin), yMax);
  x := pre_x + Ts/Ti*
      (if antiWindup == AntiWindup.BackCalc then (e - cropped/kp)
       else (if abs(cropped) > small then 0 else e));
  y := min(max(kp*e + kp*x + kFF*ff, yMin), yMax);
  annotation (Documentation(info="<html>
<p>
This is the algorithm of one step of a PI-controller with feed-forward and limited output. 
The anti-windup measure (either back-calculation or clamped) is formulated straight-forward to avoid iteration. 
Therefore the code can be:
</p>
<ul>
<li>called in a triggered block of a PI-controller</li>
<li>called in a clocked   block of a PI-controller</li>
<li>transferred to a embedded controller</li>
</ul>
<p>
Integration is replaced by an explicit forward Euler.
</p>
<p>
Anti-Windup measure: A prediction of the output is calculated without limitation is calculated. 
If there is a difference between unlimited and limited result (i.e. protected variable cropped):
</p>
<ul>
<li>BackCalc: cropped multiplied by the inverse of proportional gain is subtracted from the integrator's input</li>
<li>Clamped : The integrator is stopped (i.e. the integrator's input set to zero).</li>
<ul>
</html>"));
end piStep;
