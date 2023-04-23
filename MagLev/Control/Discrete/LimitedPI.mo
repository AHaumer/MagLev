within MagLev.Control.Discrete;
block LimitedPI "Discrete limited PI-controller with anti-windup and feed-forward"
  extends Modelica.Blocks.Interfaces.DiscreteSISO(y(start=0));
  extends BaseBlocks.LimitedPI;
  import MagLev.Types.AntiWindup;
  import MagLev.Control.Functions.piStep;
  discrete output Real x(start=0) "integrator state";
protected
  parameter SI.Time Ts=samplePeriod "Sample period";
  // avoid an algebraic loop / iteration for code on embedded controller
equation
  when sampleTrigger then
    (x, y) =  piStep(u, u_m, kp, Ti, Ts, kFF, ffInternal, antiWindup, yMin, yMax, pre(x));
  end when;
  annotation (
    Documentation(info="<html>
<p>
A time discrete implementation of <a href=\"modelica://MagLev.Control.Continuous.LimitedPI\">LimitedPI</a>. 
Note that the implementation avoids an algebraic loop for the ant-windup measure that would need iteration.
</p>
</html>"));
end LimitedPI;
