#include <stdio.h>

int main(void)
{
    int no;
    int  ans = 7;

    printf("Guess an integer from 0 to 9 \n");

    printf("Enter an integer from 0 to 9 \n");
    scanf("%d", &no);

    if (no > ans)
        printf("\a too big");
    else if (no < ans)
        printf("\a too small");
    else
        printf("correct answer!");

}