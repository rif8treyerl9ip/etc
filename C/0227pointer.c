#include <stdio.h>

void main(void) {

  int a=0;

  int *p = &a;

  printf("a=%d, p=%x \n", a,p);
  printf("a=%d, *p=%d \n", a,*p);

  a=a+10;
  printf("a=%d, p=%x \n", a,p);
  printf("a=%d, *p=%d \n", a,*p);

  *p = 25; // ポインタの値を更新
  printf("a=%d, *p=%d \n", a,*p);

  }