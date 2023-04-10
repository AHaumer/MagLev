within MagLev.ParameterRecords;
record DataZeltomPlus "Data of the plus Zeltom kit"
  import Modelica.Constants.g_n;
  extends DataZeltomStd(
    Type="ZeltomPlus",
    R=1.71,
    L=15.1E-3,
    kO=3.10E-6,
    d0=-0.02,
    dC=-0.01,
    pd=3,
    m=41.3E-3,
    alfa=2.48,
    beta=4.25E-4,
    gamma=0.31,
    Vsrc=9,
    iMax=2.5,
    dMax=-0.001,
    fSw=2500,
    kpP=0.20*1/(16*Tsub));
  annotation(defaultComponentName="data", defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>
Parameters of Zeltom's MagLevPlus system, with coil suitable for higher current, i.e. suitable for larger magnet.
<p>
</html>"));
end DataZeltomPlus;
