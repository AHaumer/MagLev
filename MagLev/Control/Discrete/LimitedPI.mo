within MagLev.Control.Discrete;
block LimitedPI "Discrete limited PI-controller with anti-windup and feed-forward"
  extends Modelica.Blocks.Interfaces.DiscreteSISO(y(start=y_start));
  extends BaseBlocks.LimitedPI;
  import Modelica.Blocks.Types.Init;
  import MagLev.Types.AntiWindup;
  import Modelica.Constants.small;
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation(Evaluate=true,
      Dialog(group="Initialization"));
  parameter Real x_start=0 "Initial or guess value of state"
    annotation (Dialog(group="Initialization"));
  parameter Real y_start=0 "Initial value of output"
    annotation(Dialog(enable=initType == Init.SteadyState or initType == Init.InitialOutput,
      group="Initialization"));
  discrete output Real e "control error";
  discrete output Real x(start=0) "integrator state";
protected
  discrete Real preview;
  discrete Real cropped;
  discrete Real y_last;
initial equation
  if initType==Init.SteadyState then
    (e - cropped/kp) = 0;
  elseif initType==Init.InitialState then
    x = x_start;
  else //initType==Init.InitialOutput
    y_last = y_start;
  end if;
  // avoid an algebraic loop / iteration for code on embedded controller
equation
  when sampleTrigger then
    e =   u - u_m;
    preview =  kp*e + kp*(pre(x) + samplePeriod/Ti*e) + kFF*ffInternal;
    cropped =  preview - min(max(preview, yMin), yMax);
    x =  pre(x) + samplePeriod/Ti*
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
