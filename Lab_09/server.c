#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/types.h>
#include<string.h>
#include<sys/wait.h>
#include <sys/ipc.h>
#include <sys/shm.h>


void bubbleSort(int array[], int size) 
{
    for(int iteration=0 ; iteration<size-1 ; iteration++)
    {
        for(int i=0 ; i<size-iteration-1 ; i++)
        {
            if(array[i] > array[i+1])
            {
                int temp = array[i];
                array[i] = array[i+1];
                array[i+1] = temp;
            }
        }
    }
}

int main(int argc, char *argv[])
{
    int size = argc - 1;
    int array[size];

    for(int i=0 ; i<size ; i++)
    {
        array[i] = atoi(argv[i+1]);
    }

    bubbleSort(array, size);

    key_t key = ftok("shmfile", 15);       /// ftok to generate unique key

    /// shmget returns an identifier in shmid
    int shmid = shmget(key, sizeof(int) * size ,0666|IPC_CREAT);

    /// shmat to attach to shared memory
    int *str = (int*) shmat(shmid, NULL, 0);

    printf("Sorted array written to shared memory.\n");
    for (int i = 0; i < size; i++) 
    {
        str[i] = array[i];
        printf("%d ",str[i]);
    }
    printf("\n");

    ///detach from shared memory
    shmdt(str);

    // Do not destroy the shared memory to keep it accessible by client.c

    /// destroy the shared memory
    /// shmctl(shmid, IPC_RMID, NULL);

    return 0;
    
}
