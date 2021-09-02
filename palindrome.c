#include<stdio.h> // header file
#include<string.h>
#include<ctype.h>

int isPalindromeWhile(char character[]) {
  int i = 0;
  int j = strlen(character)-1;
  while (i < j) {
    if (character[i] == ' ') {
      i++;
    }
    if (character[j] == ' ') {
      j--;
    }
    if (tolower(character[i]) != tolower(character[j])) {
      return 0;
    }
    i++;
    j--;
  }
  return 1;
}

void main() {
  printf(isPalindromeWhile("Was it a car or a cat I saw") ? "True" : "False");
}

