import java.util.Calendar;
import java.util.GregorianCalendar;

public class SimpleReocurringTask extends ReocurringTask {
    //constructors
    public SimpleReocurringTask() {
	super("default");
	Lucky = 7;
    }

    public SimpleReocurringTask(String title) {
	super(title);
    }

    public Calendar GetReocurrenceDays() {
	return new GregorianCalendar();
    }

    public Calendar GetDueDate() {
	return new GregorianCalendar();
    }
}