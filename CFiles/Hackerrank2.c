#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
//Complete the following function.

int find_nth_term(int n, int a, int b, int c) {
  //Write your code here.
  int value=0;
  if(n==0)
  {
      value = value+ 0;
  }
  if (n==1) 
  {
     value= value + a;
  }
  else if (n==2)
  {
      value =value+ b;
  }

  else if (n==3)
  {
      value = value + c;
  }
    else 
    {
        value =value +find_nth_term(n-1,a,b,c) + find_nth_term(n-2,a,b,c)+find_nth_term(n-3,a,b,c);

    }

  return value;
}

int main() {
    int n, a, b, c;
  
    scanf("%d %d %d %d", &n, &a, &b, &c);
    int ans = find_nth_term(n, a, b, c);
 
    printf("%d\n", ans); 
    return 0;
}