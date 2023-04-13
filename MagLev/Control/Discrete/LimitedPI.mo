within MagLev.Control.Discrete;
block LimitedPI "Discrete limited PI-controller with anti-windup and feed-forward"
  extends Modelica.Blocks.Interfaces.DiscreteSISO(final startTime=0);
  extends BaseBlocks.LimitedPI;
  import Modelica.Blocks.Types.Init;
  import MagLev.Types.AntiWindup;
  import Modelica.Constants.small;
  discrete output Real e "control error";
  discrete output Real x "integrator state";
protected
  discrete Real preview(start=y0);
  discrete Real cropped(start=0);
initial equation
  if initType==Init.SteadyState then
    (e - cropped/kp) = 0;
  elseif initType==Init.InitialState then
    x = x0;
  else //initType==Init.InitialOutput
    y = y0;
  end if;
algorithm
  when sampleTrigger then
    e :=  u - u_m;
    x := pre(x) + samplePeriod/Ti*e;
    preview := kp*e + kp*x + kFF*ffInternal;
    cropped := preview - min(max(preview, yMin), yMax);
    x := pre(x) + samplePeriod/Ti*
      (if antiWindup==AntiWindup.BackCalc then (e - cropped/kp)
      else (if cropped>small then 0 else e));
    y := min(max(kp*e + kp*x + kFF*ffInternal, yMin), yMax);
  end when;
  annotation (
    Documentation(info="<html>
<p>
A time discrete implementation of <a href=\"modelica://MagLev.Control.Continuous.LimitedPI\">LimitedPI</a>. 
Note that the implementation avoids an algebraic loop for the ant-windup measure that would need iteration.
</p>
</html>"));
end LimitedPI;
