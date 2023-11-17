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

int main()
{
    int size = 5;

    key_t key = ftok("shmfile", 15);         /// ftok to generate unique key

    // shmget returns an identifier in shmid
    int shmid = shmget(key, sizeof(int) * size, 0666 | IPC_CREAT);

    // shmat to attach to shared memory
    int *str = (int *)shmat(shmid, NULL, 0);

    int number = 5;
    int answer = binarySearch(str, number, 0, size-1);
    if (answer == -1)
        printf("Not found\n");
    else
        printf("Element is found at index %d\n", answer);
        
    /// detach from shared memory
    shmdt(str);
    
    /// destroy the shared memory
    shmctl(shmid, IPC_RMID, NULL);
    return 0;
}