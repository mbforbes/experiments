import java.util.Calendar;

public abstract class Task {
    // constants
    public int Lucky = 8;

    // fields
    private final String title;

    // methods (constructors)
    public Task(String title) {
	this.title = title;
    }

    // methods
    public abstract Calendar GetDueDate();
    
    // inner types
}