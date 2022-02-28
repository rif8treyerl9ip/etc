#include <stdio.h>

void main(void) {

  int a=0, c=5;
  int *b = &a;
  int *d = &c;

  printf("a=%d, b=%x, d=%x\n", a,b,d);
  printf("a=%d, *b=%d, c=%d, *d=%d \n", a,*b, c, *d);

  a=a+15; c=c+10;
  printf("a=%d, *b=%d, c=%d, *d=%d \n", a,*b, c, *d);

  *b = 25; d=b; // ポインタの値を更新,ポインタを代入
  printf("a=%d, b=%x, d=%x\n", a,b,d);
  printf("a=%d, *b=%d, c=%d, *d=%d \n", a,*b, c, *d);
  b=&c;
  printf("a=%d, *b=%d, c=%d, *d=%d \n", a,*b, c, *d);


  }