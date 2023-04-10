within MagLev.Control.Discrete;
block LimitedPI "Discrete limited PI-controller with anti-windup and feed-forward"
  extends Modelica.Blocks.Interfaces.DiscreteSISO(final startTime=0);
  extends BaseBlocks.BaseLimitedPI;
  import Modelica.Blocks.Types.Init;
  import MagLev.Types.AntiWindup;
  import Modelica.Constants.eps;
  parameter Boolean InstantOutput=true "Otherwise previous result";
  discrete output Real controlError "Control error (set point - measurement)";
  discrete output Real preView;
  discrete output Real integralPart(start=x_start);
  discrete output Real actVal(start=y_start);
protected
  discrete Real cropped(start=0);
  Boolean clamped(start=false);
initial equation
  if initType == Init.SteadyState and useI then
    controlError = 0;
  elseif initType == Init.InitialState and useI then
    pre(integralPart) = x_start;
  elseif initType == Init.InitialOutput and useI then
    pre(actVal) = y_start;
  end if;
algorithm
  when sampleTrigger then
    controlError := u - u_m;
    //preview output with explicit Euler without influence of limitation
    integralPart := if not useI then 0 else pre(integralPart) + controlError*samplePeriod/Ti;
    preView :=k*(controlError + integralPart) + kFFInt*feedForwardInt;
    cropped :=preView - min(max(preView, yMinInt), yMaxInt);
    clamped :=abs(cropped) > eps;
    //explicit Euler with influence of previewed limitation
    integralPart :=if not useI then 0 else pre(integralPart) +
      (if antiWindup == AntiWindup.BackCalc then (controlError - cropped/k)*samplePeriod/Ti
       else (if clamped then 0 else controlError*samplePeriod/Ti));
    actVal := min(max((k*(controlError + integralPart) + kFFInt*feedForwardInt), yMinInt), yMaxInt);
    //output shall be active immediately or at next time instant of communication
    y := if InstantOutput then actVal else pre(actVal);
  end when;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
        Line(visible=useI, points={{-80,-80},{-80,-20},{40.8594,66.3281},
              {60,66}},                                          color = {0,0,127}),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{0,6},{60,-56}},
          textColor={192,192,192},
          textString="PI", visible=useI),
        Text(
          extent={{0,6},{60,-56}},
          textColor={192,192,192},
          textString="P", visible=not useI),
        Line(visible=not useI, points={{-80,-80},{-80,24},{56,24}},  color = {0,0,127})}),
    Documentation(info="<html>
<p>
A time discrete implementation of <a href=\"modelica://MagLev.Control.Continuous.LimitedPI\">LimitedPI</a>. 
Note that the implementation avoids an algebraic loop for the ant-windup measure that would need iteration.
</p>
</html>"));
end LimitedPI;
