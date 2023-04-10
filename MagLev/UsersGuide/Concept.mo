within MagLev.UsersGuide;
class Concept "Concept"
  extends Modelica.Icons.Information;
  annotation (preferredView="info",Documentation(info="<html>
<p>
The models are based on a kit provided by <a href=\"https://zeltom.com/home.html\">Zeltom</a>.
</p>
<p>
A permanent magnet is attracted by a magnetic field caused by the current through a coil, ideally balancing the gravitational force. 
The position of the magnet is detected by hall sensor. The output depends both on the magnet's position and the coil's current. 
The coil is fed by a h-bridge used as a buck converter, since inverting the current direction means inverting the magnetic field
which would cause the permanent magnet to flip by 180&deg; instead of being repelled. 
Control of the instable system is described in a separate chapter.
</p>
<p>
The physical laws and the parameters are described in detail in the references.
</p>
</html>"));
end Concept;
