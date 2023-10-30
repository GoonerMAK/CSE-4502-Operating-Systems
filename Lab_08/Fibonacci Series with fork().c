#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <number>\n", argv[0]);
        return 1;
    }

    int n = atoi(argv[1]);

    if (n < 0) {
        printf("Please provide a non-negative number.\n");
        return 1;
    }

    int a = 0, b = 1, sum;
    pid_t pid = fork();

    if (pid < 0) {
        perror("Fork failed\n");
        return 1;
    } 
    
    else if (pid == 0) {
        printf("Child is making the Fibonacci sequence:\n");
        for (int i = 0; i < n; i++) {
            printf("%d ", a);
            sum = a + b;
            a = b;
            b = sum;
        }
    } 
    
    else {
        wait(NULL);
    }

    printf("\n");

    return 0;
}
