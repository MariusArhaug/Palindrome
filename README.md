# Palindrome
Aseembly / C checker for plaindrome strings

C code is created to give a full understanding how a palindrome checker should be implemented 

```c
int checkPalindrome(char c[]) {
  int i = 0;
  int j = strlen(c)-1;
  while (i < j) {
    if (c[i] == ' ') {
      i++;
    }
    if (c[j] == ' ') {
      j--;
    }
    if (tolower(c[i]) != tolower(c[j])) {
      return 0;
    }
    i++;
    j--;
  }
  return 1;
}
```

The checker is case insensitive and dosen't care about spaces, it assumes that the input is only of valid characters such as [a-z|A-Z|1..9]. Returns 0 = False or 1 = True. Using this "high language" checker we can create an ARMv7 assembly program to do the same
