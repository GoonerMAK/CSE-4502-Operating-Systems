#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

int isPrime(int n) 
{
    if (n <= 1) {
        return 0; // Not prime
    }

    for (int i = 2 ; i * i <= n ; i++) {
        if (n % i == 0) {
            return 0; // Not prime
        }
    }
    return 1; // Prime
}

int main(int argc, char *argv[])
{
    int number, count = 0;
    printf("The Number ");
    scanf("%d", &number);

    printf("Prime numbers less than or equal to %d are:\n", number);

    for (int i = 2; i <= number; i++) {
        if (isPrime(i)) {
            printf("%d\n", i);
        }
    }

    return 0;    
}
