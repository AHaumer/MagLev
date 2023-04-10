within MagLev.ParameterRecords;
record DataZeltomStd "Data of the standard Zeltom kit"
  import Modelica.Constants.g_n;
  extends Modelica.Icons.Record;
  parameter String Type="ZeltomStd";
  parameter SI.Resistance R=2.41 "Resistance of coil"
    annotation(Dialog(group="Coil and PM"));
  parameter SI.Inductance L=15.03E-3 "Inductance of coil"
    annotation(Dialog(group="Coil and PM"));
  parameter Real kO=17.31E-9 "Original force per current and distance^pd [N.m^pd/A]"
    annotation(Dialog(group="Coil and PM"));
  parameter SI.Position d0=-0.02 "Steady-state Position below coil"
    annotation(Dialog(group="Coil and PM"));
  parameter SI.Position dC(min=d0)=-0.01 "Steady-state Position below coil without coil current > d0"
    annotation(Dialog(group="Coil and PM"));
  parameter Real k=kO*(1 - (abs(dC/d0))^pd) "Equivalent force per current and distance^pd [N.m^pd/A]"
    annotation(Dialog(group="Coil and PM"));
  parameter SI.Current iC=m*g_n/k*abs(dC)^pd "Equivalent current describing force between pm and iron core without coil current"
    annotation(Dialog(group="Coil and PM"));
  parameter Integer pd=4 "Power of distance to calculate force"
    annotation(Dialog(group="Coil and PM"));
  parameter SI.Mass m=3.02E-3 "Mass of magnet"
    annotation(Dialog(group="Coil and PM"));

  parameter SI.Voltage alfa=2.48 "Coefficient 1 (constant)"
    annotation(Dialog(group="Hall effect sensor"));
  parameter Real beta(unit="V.m2")=2.92E-4 "Coefficient 2  (distance)"
    annotation(Dialog(group="Hall effect sensor"));
  parameter SI.Resistance gamma=0.48 "Coefficient 3 (current)"
    annotation(Dialog(group="Hall effect sensor"));
  parameter SI.Position dNoise=5e-7 "Used to estimate noise on hall sensor output"
    annotation(Dialog(group="Hall effect sensor"));
  parameter SI.Voltage eNoise=beta/(d0 + dNoise/2)^2 - beta/(d0 - dNoise/2)^2 "Noise on hall sensor output"
    annotation(Dialog(group="Hall effect sensor"));

  parameter SI.Current i0=g_n*m*(abs(d0))^pd/k - iC "Current through coil"
    annotation(Dialog(tab="Steady state"));
  parameter SI.Voltage v0=R*i0 "Voltage across coil"
    annotation(Dialog(tab="Steady state"));
  parameter SI.Force f0=m*g_n "Force on magnet"
    annotation(Dialog(tab="Steady state"));
  parameter SI.Voltage e0=alfa + beta/d0^2 + gamma*i0 "Signal of hall effect sensor"
    annotation(Dialog(tab="Steady state"));

  parameter SI.Voltage Vsrc=9 "Source voltage"
    annotation(Dialog(tab="Steady state", group="Limits"));
  parameter SI.Current iMax=1.0 "Current limit"
    annotation(Dialog(tab="Steady state", group="Limits"));
  parameter SI.Force fMax=k/(abs(d0))^pd*(iC + iMax) "Max. force in steady state position"
    annotation(Dialog(tab="Steady state", group="Limits"));
  parameter SI.Position dMax=-0.001 "Nearest position of magnet below coil"
    annotation(Dialog(tab="Steady state", group="Limits"));
  parameter SI.Position dMin=-(k/(m*g_n)*(iC + iMax))^(1.0/pd) "Farest position of magnet below coil"
    annotation(Dialog(tab="Steady state", group="Limits"));

  parameter SI.Frequency fSw=2500 "Switching frequency"
    annotation(Dialog(tab="Control"));
  parameter SI.Time Td=1/fSw "Dead time (double for discrete control!)"
    annotation(Dialog(tab="Control"));
  parameter SI.Resistance kpI=L/(2*Td) "Proportional gain"
    annotation(Dialog(tab="Control", group="Current controller"));
  parameter SI.Time TiI=L/R "Integral time constant"
    annotation(Dialog(tab="Control", group="Current controller"));
  parameter SI.Time Tsub=2*Td "Substitute time constant"
    annotation(Dialog(tab="Control", group="Current controller"));

  parameter Real a=2 "Parameter of symmetrical optimum"
    annotation(Dialog(tab="Control", group="Speed controller"));
  parameter Real kpv(unit="N.s/m")=m/(a*Tsub) "Proportional gain"
    annotation(Dialog(tab="Control", group="Speed controller"));
  parameter SI.Time Tiv=a^2*Tsub "Integral time constant"
    annotation(Dialog(tab="Control", group="Speed controller"));

  parameter Real kpP(unit="1/s")=1/(16*Tsub) "Upper limit of proportional gain"
    annotation(Dialog(tab="Control", group="Position controller"));
  parameter Real ktuneP=0.50 "Tuning factor for proportional gain"
    annotation(Dialog(tab="Control", group="Position controller"));
  annotation(defaultComponentName="data", defaultComponentPrefixes="parameter",
    Icon(graphics={Text(
          extent={{-100,-10},{100,-30}},
          textColor={0,0,255},
          textString="%Type")}),
    Documentation(info="<html>
<p>
Parameters of Zeltom's Standard system, enriched by calculation of steady-state equilibrium and controller parameters.
<p>
</html>"));
end DataZeltomStd;
