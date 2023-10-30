#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <program> [arguments]\n", argv[0]);
        return 1;
    }

    pid_t pid = fork();

    if (pid < 0) {
        perror("Fork failed");
        return 1;
    } else if (pid == 0) {
        printf("This is a Child Process\n");
        exit(0);
    } else {
        wait(NULL);
        printf("Child process has completed.\n");

        if (execvp(argv[1], &argv[1]) == -1) {
            perror("Exec failed");
            return 1;
        }
    }

    return 0;
}
