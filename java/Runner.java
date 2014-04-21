import test.*;

public class Runner {
    public static void main(String[] args) {
	// initialize (though they don't do it)
	Base b = new Base();
	Sub s = new Sub();
	Bub u = new Bub();
	
	//test2
	b = (Sub) s; //This cast does absolutely nothing -- type is still Base, value is still Sub
	s = (Sub) b; //This cast does something -- type is now compatable (is Sub), value is Sub

	// do some things
	//b = (Base) s; // cast from a sub up to a base
	//s = (Sub) b;  // cast from a base down to a sub 
	//u = (Bub) b;  // cast from sub across to a bub

	// done
	System.out.println("finished");
    }
}