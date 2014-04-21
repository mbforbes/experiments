public class Palindrome {
    public static void main(String[] args) {
	p(isPalindrome(null));  // false
	p(isPalindrome(""));    // true
	p(isPalindrome("a"));   // true
	p(isPalindrome("bb"));  // true
	p(isPalindrome("ba"));  // false
	p(isPalindrome("dad")); // true
	p(isPalindrome("foo")); // false
	p(isPalindrome("baab"));// true
	p(isPalindrome("buba"));// false
    }

    public static boolean isPalindrome(String s) {
	if (s == null)
	    return false;
	int i = 0;
	int j = s.length() - 1;
	while (i <= j) {
	    if (s.charAt(i) != s.charAt(j))
		return false;
	    i++;
	    j--;
	}
	return true;
    }

    public static void p(Object o) {
	System.out.println(o);
    }
}