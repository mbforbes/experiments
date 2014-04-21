import java.util.Calendar;

public abstract class ReocurringTask extends Task {
    // constants

    // methods (constructors)
    public ReocurringTask(String title) {
	super(title);
    }

    // methods
    public abstract Calendar GetReocurrenceDays();

    // inner types
}
