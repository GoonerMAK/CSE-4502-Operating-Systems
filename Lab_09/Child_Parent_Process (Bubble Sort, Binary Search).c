#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/types.h>
#include<string.h>
#include<sys/wait.h>
#include <sys/ipc.h>
#include <sys/shm.h>


int binarySearch(int array[], int x, int low, int high)
{
    if(high >= low)
    {
      int mid = low + (high - low) / 2;

      if (array[mid] == x)
        return mid;

      if (array[mid] > x)
        return binarySearch(array, x, low, mid - 1);

      else
        return binarySearch(array, x, mid + 1, high);
    }

    return -1;
}


int main(int argc, char *argv[])
{
    int size = argc - 1;
    int array[size];

    for(int i=0 ; i<size ; i++)
    {
        array[i] = atoi(argv[i+1]);
    }

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


    /// shmget returns an identifier in shmid
    int shmid = shmget(IPC_PRIVATE, sizeof(int) * argc ,0666|IPC_CREAT);

    /// shmat to attach to shared memory
    int *str = (int*) shmat(shmid, NULL, 0);

    pid_t p = fork();     /// Creating a parent process

    if (p < 0)
    {
        printf("fork Failed" );
        return 1;
    }

    /// Parent process
    else if (p > 0)
    {
        printf("Inside parent:");
        for(int i=0 ; i<size ; i++)
        {
            str[i]=array[i];
            printf("%d ",str[i]);
        }
        printf("\n");
        printf("Data written in memory: \n");


        wait(NULL);

        printf("Inside parent:");
        for(int i=0 ; i<size ; i++)
        {
            printf("%d ",str[i]);
        }
        printf("\n");


        ///detach from shared memory
        shmdt(str);
    }

    /// child process
    else
    {
        printf("Data read from memory: \n");
        printf("Inside child:");

        for(int i=0 ; i<size ; i++)
        {
            printf("%d ",str[i]);
        }
        printf("\n");

        int number = 5;
        int answer = binarySearch(str, number, 0, size-1);

        if (answer == -1)
            printf("Not found\n");
        else
            printf("Element is found at index %d\n", answer);

        /// detach from shared memory
        shmdt(str);

        /// destroy the shared memory
        shmctl(shmid,IPC_RMID,NULL);

        exit(0);
    }
}
