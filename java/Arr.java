public class Arr {
    public static void main(String[] args) {
	int[] arr = {5,6,7};
	manip(arr);
	for (int i = 0; i < arr.length; i++)
	    System.out.println(arr[i] + " ");
    }

    public static void manip(int[] a) {
	a[0] = 100;
    }
}