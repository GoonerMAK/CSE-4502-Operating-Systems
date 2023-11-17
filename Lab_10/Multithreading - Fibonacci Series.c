#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX_SIZE 1000

// Structure to hold data of each thread
typedef struct {
    int* fibonacci_sequence;
    int num;
} ThreadData;


// Function to be called by the threads
void* generateFibonacci(void* arg) {
    ThreadData* data = (ThreadData*)arg;

    int a = 0, b = 1, sum;

    for (int i = 0; i < data->num; i++) {
        data->fibonacci_sequence[i] = a;
        sum = a + b;
        a = b;
        b = sum;
    }

    pthread_exit(NULL);
}


int main(int argc, char *argv[]) 
{
    if (argc != 2) {
        printf("Usage: %s <number>\n", argv[0]);
        return 1;
    }

    int num = atoi(argv[1]);

    if (num < 0) {
        printf("Please provide a non-negative number.\n");
        return 1;
    }

    int fibonacci_sequence[MAX_SIZE];

    // Child thread to generate Fibonacci sequence
    pthread_t tid;
    ThreadData data;
    data.fibonacci_sequence = fibonacci_sequence;
    data.num = num;

    pthread_create(&tid, NULL, generateFibonacci, (void*)&data);

    pthread_join(tid, NULL);    // Wait for the child thread to finish

    // Output the generated Fibonacci sequence
    printf("Fibonacci sequence generated by the child thread:\n");
    for (int i = 0; i < num; i++) {
        printf("%d ", fibonacci_sequence[i]);
    }
    printf("\n");

    return 0;
}