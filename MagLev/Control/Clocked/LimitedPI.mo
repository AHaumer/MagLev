within MagLev.Control.Clocked;
block LimitedPI "Discrete limited PI-controller with anti-windup and feed-forward"
  extends Modelica.Clocked.RealSignals.Interfaces.PartialClockedSISO;
  extends BaseBlocks.LimitedPI;
  import Modelica.Blocks.Types.Init;
  import MagLev.Types.AntiWindup;
  import Modelica.Constants.small;
  discrete output Real e "control error";
  discrete output Real x "integrator state";
protected
  SI.Time Ts = interval(u) "Sample time";
  discrete Real preview(start=y0);
  discrete Real cropped(start=0);
  discrete Real y_last;
initial equation
  if initType==Init.SteadyState then
    (e - cropped/kp) = 0;
  elseif initType==Init.InitialState then
    x = x0;
  else //initType==Init.InitialOutput
    y_last = y0;
  end if;
  // avoid an algebraic loop / iteration for code on embedded controller
equation
  when Clock() then
    e =   u - u_m;
    preview =  kp*e + kp*(previous(x) + Ts/Ti*e) + kFF*ffInternal;
    cropped =  preview - min(max(preview, yMin), yMax);
    x =  previous(x) + Ts/Ti*
      (if antiWindup==AntiWindup.BackCalc then (e - cropped/kp)
      else (if cropped>small then 0 else e));
    y_last =  min(max(kp*e + kp*x + kFF*ffInternal, yMin), yMax);
  end when;
  y = y_last;
  annotation (
    Documentation(info="<html>
<p>
A time discrete implementation of <a href=\"modelica://MagLev.Control.Continuous.LimitedPI\">LimitedPI</a>. 
Note that the implementation avoids an algebraic loop for the ant-windup measure that would need iteration.
</p>
</html>"));
end LimitedPI;
