within MagLev.Control.Discrete;
block LimitedPI "Discrete limited PI-controller with anti-windup and feed-forward"
  extends Modelica.Blocks.Interfaces.DiscreteSISO(y(start=0));
  extends BaseBlocks.LimitedPI;
  import MagLev.Types.AntiWindup;
  import Modelica.Constants.small;
  discrete output Real e "control error";
  discrete output Real x(start=0) "integrator state";
protected
  discrete Real preview;
  discrete Real cropped;
  // avoid an algebraic loop / iteration for code on embedded controller
equation
  when sampleTrigger then
    e =   u - u_m;
    preview =  kp*e + kp*(pre(x) + samplePeriod/Ti*e) + kFF*ffInternal;
    cropped =  preview - min(max(preview, yMin), yMax);
    x =  pre(x) + samplePeriod/Ti*
      (if antiWindup==AntiWindup.BackCalc then (e - cropped/kp)
      else (if cropped>small then 0 else e));
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
