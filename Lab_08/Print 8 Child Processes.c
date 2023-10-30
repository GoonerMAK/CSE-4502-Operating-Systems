#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>

int main()
{
    int child_processes = 8;

    for(int i=0 ; i<child_processes ; i++) 
    {
        if(fork() == 0)
        {
            printf("[son] pid %d from [parent] pid %d\n",getpid(),getppid());
            exit(0);
        }
    }

    for(int i=0 ; i<child_processes ; i++) 
    wait(NULL);
     
}