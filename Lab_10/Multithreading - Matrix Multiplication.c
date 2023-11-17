#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

// Global declaring matrices A, B, and C
int** A;
int** B;
int** C;

int row_a, col_a, row_b, col_b, row_c, col_c;
int total_working_threads;

// Structure to hold data of each thread
typedef struct {
    int row;
    int col;
} ThreadData;

// Function to be called by the threads
void* matrixMultiplyElement(void* arg) {
    ThreadData* data = (ThreadData*)arg;

    int i = data->row;
    int j = data->col;

    C[i][j] = 0;
    for (int n = 0; n < col_a; n++) {
        C[i][j] += A[i][n] * B[n][j];
    }

    pthread_exit(NULL);
}


// Function to take input for a matrix
void inputMatrix(int** matrix, int rows, int cols, const char* matrixName) 
{
    printf("Enter values for matrix %s:\n", matrixName);

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) 
        {
            printf("%s[%d][%d]: ", matrixName, i + 1, j + 1);
            scanf("%d", &matrix[i][j]);
        }
    }
}


int main(int argc, char *argv[])
{
    printf("Mention the rows of Matrix A: ");
    scanf("%d", &row_a);
    printf("Mention the columns of Matrix A: ");
    scanf("%d", &col_a);
    printf("Mention the rows of Matrix B: ");
    scanf("%d", &row_b);
    printf("Mention the columns of Matrix B: ");
    scanf("%d", &col_b);

    if(col_a != row_b){
        printf("Matrix Multiplication Not Possible!\n");
        return 0;
    } else {
        row_c = row_a;
        col_c = col_b;
    }

    total_working_threads = row_c*col_c;

    // Initialize matrices A, B, and C
    A = (int**)malloc(row_a * sizeof(int*));
    B = (int**)malloc(row_b * sizeof(int*));
    C = (int**)malloc(row_c * sizeof(int*));

    for (int i = 0; i < row_a; i++) {
        A[i] = (int*)malloc(col_a * sizeof(int));
    }

    for (int i = 0; i < row_b; i++) {
        B[i] = (int*)malloc(col_b * sizeof(int));
    }

    for (int i = 0; i < row_c; i++) {
        C[i] = (int*)malloc(col_c * sizeof(int));
    }

    // Input values for matrices A and B
    inputMatrix(A, row_a, col_a, "A");
    inputMatrix(B, row_b, col_b, "B");

    // Creating worker threads for matrix multiplication
    pthread_t* threads = (pthread_t*)malloc(total_working_threads * sizeof(pthread_t));
    ThreadData* threadData = (ThreadData*)malloc(total_working_threads * sizeof(ThreadData));

    int threadCounter = 0;

    for (int i = 0; i < row_c; i++) {
        for (int j = 0; j < col_c; j++) 
        {
            threadData[threadCounter].row = i;
            threadData[threadCounter].col = j;
            pthread_create(&threads[threadCounter], NULL, matrixMultiplyElement, (void*)&threadData[threadCounter]);
            threadCounter++;
        }
    }

    for (int i = 0; i < total_working_threads; i++)     // Wait for worker threads to finish
    {
        pthread_join(threads[i], NULL);
    }

    printf("Matrix C (Result of A * B):\n");    // Output the result matrix C
    for (int i = 0; i < row_c; i++) {
        for (int j = 0; j < col_c; j++) {
            printf("%d\t", C[i][j]);
        }
        printf("\n");
    }

    // Free all dynamically allocated memory
    for (int i = 0; i < row_a; i++) {
        free(A[i]);
    }
    free(A);

    for (int i = 0; i < row_b; i++) {
        free(B[i]);
    }
    free(B);

    for (int i = 0; i < row_c; i++) {
        free(C[i]);
    }
    free(C);

    free(threads);
    free(threadData);

    return 0;
}
