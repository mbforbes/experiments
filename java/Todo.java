import java.util.Calendar;
import java.util.GregorianCalendar;

public class Todo {
    public static void main(String args[]) {
	ReocurringTask RTask1 = new SimpleReocurringTask();
	Task Task1 = (Task) RTask1;
	Calendar myCal = Task1.GetDueDate();
    }
}