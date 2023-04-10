within MagLev.Examples;
model SteadyStateCharacteristic "Characteristic in stady state"
  extends Modelica.Icons.Example;
  import Modelica.Constants.g_n;
  parameter ParameterRecords.DataZeltomStd      data annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  SI.Voltage v "Voltage across coil";
  SI.Current i(start=0.25) "Current through coil";
  SI.Voltage e "Output of Hall effect sensor";
  parameter SI.Position dMin=-0.030;
  parameter SI.Position dMax=-0.005;
  parameter SI.Time deltaT=0.1;
  SI.Position d=dMin + (dMax - dMin)/deltaT*time "Position of magnet below coil";
  SI.Force f "Force of coil on magnet";
equation
  assert(d<data.dMax, "Magnet hit coil");
  v = data.R*i "Voltage drop of coil";
  f = data.k*(data.iC + i)/(abs(d))^data.pd "Force on magnet";
  e = data.alfa + data.beta/d^2 + data.gamma*i "Output of Hall effect sensor";
  0 = g_n - f/data.m "Equation of motion";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
                                             Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=0.1,
      Interval=0.001,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
Contains the system equations without derivatives, therefore calculating equilibrium solutions <i>i=f(d)</i>.
</p>
</html>"));
end SteadyStateCharacteristic;
