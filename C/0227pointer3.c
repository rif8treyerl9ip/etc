#include <stdio.h>
  
// void setTen(int a) {
//   a=10;
// }

// int main(void) {
//   int a=20;
//   setTen(a);
//   printf("%d\n", a);
//   return 0;
//   }

// ポインタ型変数を定義
void setTen(int *a) {
// ポインタ型変数の「実体」を変更
  *a=10;
}

int main(void) {
  int a=20;
  setTen(&a);
  printf("%d\n", a);
  printf("%d\n", &a);
  return 0;
  }