#include <stdio.h>

int main(void)
{
    int no;
    int ans = 7;

    printf("Guess an integer from 0 to 9 \n");

    do {
        printf("Enter an integer from 0 to 9 \n");
            
        // scanf(”書式文字列”, &変数名1, &変数名2, ・・・)
        scanf("%d", &no);

        printf (no == ans);

        if (no > ans)
            printf("\a too big\n");
        else if (no < ans)
            printf("\a too small\n");
            } while (no!=ans);

    printf("correct answer!");

    return 0;

}