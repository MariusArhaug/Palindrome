#include<stdio.h> // header file
#include<string.h>

void isPalindrome(char character[]) {
  int length = strlen(character);
  for (int i = 0; i < length; i++) {
    if (character[i] != character[length-1-i]) {
      printf("False");
      return;
    } 
  }
  printf("True");
}

void main() {
  isPalindrome("abab");
}

