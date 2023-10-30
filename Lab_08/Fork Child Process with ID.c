#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>

int main()
{
    int id = 0;
    pid_t process = fork();

    if(process<0){
      perror("fork failed\n");
      exit(1);
    }

    else if (process == 0)
    {
        id = 200042115;
        printf("Child has x = %d\n", id);
    }
        
    else
    {
        id = 115;
        printf("Parent has x = %d\n", id);
    }
        
    return 0;
}