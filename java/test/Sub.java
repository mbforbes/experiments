package test;

public class Sub extends Base {

    public Sub() {
	// call to super() constructor must be first statement in constructor
	//System.out.println("what's up");
	//super();
    }

    // overrides Base.a()
    public void a() {
	//System.out.println("what's up");	
	// this is OK -- can call super.method() at any point in a normal method
	//super.a();
    }
}