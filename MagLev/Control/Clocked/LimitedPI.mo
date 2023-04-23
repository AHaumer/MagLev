within MagLev.Control.Clocked;
block LimitedPI "Discrete limited PI-controller with anti-windup and feed-forward"
  extends Modelica.Clocked.RealSignals.Interfaces.PartialClockedSISO(y(start=0));
  extends BaseBlocks.LimitedPI;
  import MagLev.Types.AntiWindup;
  import MagLev.Control.Functions.piStep;
  import Modelica.Constants.small;
  discrete output Real e "control error";
  discrete output Real x(start=0) "integrator state";
protected
  SI.Time Ts = interval(u) "Sample time";
  discrete Real predict "Prediczion w/o limitation";
  discrete Real cropped "Cropped part";
  // avoid an algebraic loop / iteration for code on embedded controller
equation
  when Clock() then
  //(x, y) =  piStep(u, u_m, kp, Ti, Ts, kFF, ffInternal, antiWindup, yMin, yMax, previous(x));
    e =   u - u_m;
    predict =  kp*e + kp*(previous(x) + Ts/Ti*e) + kFF*ffInternal;
    cropped =  predict - min(max(predict, yMin), yMax);
    x =  previous(x) + Ts/Ti*
      (if antiWindup==AntiWindup.BackCalc then (e - cropped/kp)
      else (if abs(cropped)>small then 0 else e));
    y =  min(max(kp*e + kp*x + kFF*ffInternal, yMin), yMax);
  end when;
  annotation (
    Documentation(info="<html>
<p>
A time discrete implementation of <a href=\"modelica://MagLev.Control.Continuous.LimitedPI\">LimitedPI</a>. 
Note that the implementation avoids an algebraic loop for the ant-windup measure that would need iteration.
</p>
</html>"));
end LimitedPI;
