#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/types.h>
#include<string.h>
#include<sys/wait.h>
#include <sys/ipc.h>
#include <sys/shm.h>


void generateFibonacci(int n, int *fibonacci_sequence) {
    int a = 0, b = 1, sum;

    for (int i = 0; i < n; i++) {
        fibonacci_sequence[i] = a;
        sum = a + b;
        a = b;
        b = sum;
    }
}

int main(int argc, char *argv[])
{
     if (argc != 2) {
        printf("Usage: %s <number>\n", argv[0]);
        return 1;
    }

    int n = atoi(argv[1]);

    if (n < 0) {
        printf("Please provide a non-negative number.\n");
        return 1;
    }

    int pipe_fd[2];
    if (pipe(pipe_fd) == -1) {
        perror("Pipe failed\n");
        return 1;
    }

    pid_t pid = fork();    // Fork a child process

    if (pid < 0) {
        perror("Fork failed\n");
        return 1;
    } 
    
    else if (pid == 0) 
    {
        close(pipe_fd[0]);              // Closing the reading end of the pipe
        printf("Child is making the Fibonacci sequence:\n");
        
        int *fibonacci_sequence = malloc(n * sizeof(int));
        generateFibonacci(n, fibonacci_sequence);

        // Writing the Fibonacci sequence to the pipe
        write(pipe_fd[1], fibonacci_sequence, n * sizeof(int));

        close(pipe_fd[1]); // Closing the writing end of the pipe
        free(fibonacci_sequence);

    } 
    
    // Parent process
    else {
        close(pipe_fd[1]); // Closing the writing end of the pipe

        wait(NULL);

        printf("Parent is waiting for the child to finish...\n");

        int *fibonacci_sequence = malloc(n * sizeof(int));

        // Reading the Fibonacci sequence from the pipe
        read(pipe_fd[0], fibonacci_sequence, n * sizeof(int));

        printf("Generated Fibonacci sequence by the child process:\n");
        for (int i = 0; i < n; i++) {
            printf("%d ", fibonacci_sequence[i]);
        }
        printf("\n");

        close(pipe_fd[0]); // Closing the reading end of the pipe
        free(fibonacci_sequence);
    
    }

    printf("\n");

    return 0;
    
}
