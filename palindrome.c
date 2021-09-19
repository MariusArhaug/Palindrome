#include<stdio.h> // header file
#include<string.h>
#include<ctype.h>

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

void main() {
  printf(checkPalindrome("Was it a car or a cat I saw") ? "True" : "False");
}

