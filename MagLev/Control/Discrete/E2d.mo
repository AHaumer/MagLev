within MagLev.Control.Discrete;
block E2d "Calculate position from hall sensor signal"
  extends Modelica.Blocks.Interfaces.DiscreteBlock;
  extends MagLev.Control.BaseBlocks.E2d(d(start=0));
protected
  discrete Real pre_d "pre(d)";
equation
  when sampleTrigger then
    d = -sqrt(beta/abs(e - alfa - gamma*i));
    pre_d = -sqrt(beta/abs(pre(e) - alfa - gamma*pre(i)));
    d_der = (d - pre(d))/samplePeriod;
  end when;
  annotation (                   Documentation(info="<html>
<p>
Calculates the position of the magnet from the output of the hall effect sensor, using the known current. 
Additionally, the velocity of the magnet is determined by differentiating the position. 
A time discrete differentiation is used.
</p>
</html>"));
end E2d;
