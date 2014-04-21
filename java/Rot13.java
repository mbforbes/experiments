public class Rot13 {
    public static void main(String[] args) {
	System.out.println(rot13("normal"));
    }

    public static String rot13(String s) {
	if (s == null)
	    return null;
	String result = "";
	for (int i = 0; i < s.length(); i++) {
	    int c = s.charAt(i) + 13;
	    if (c > (int)'z')
		c = c % (int)('z') + (int)('a') - 1;
	    result += (char)(c);
	}
	return result;
    }
}