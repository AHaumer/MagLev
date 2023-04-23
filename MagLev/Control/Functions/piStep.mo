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
end piStep;
