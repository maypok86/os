#include <stdio.h>
#include <sys/shm.h>
#include <sys/stat.h>
#include <memory.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#include <sys/wait.h>
#include <time.h>

#define ARRAY_SIZE 20

pid_t kill_pid = -1;
int done_flag = 0;

void handle_alarm(pid_t sig) {
    if (sig == SIGALRM && kill_pid >= 0) {
        kill(kill_pid, SIGTERM);
        int status;
        wait(&status);
        done_flag = 1;
    }
}

int random_number(int min, int max) {
    srand(time(NULL));
    return (rand() % (max - min)) + min;
}

int main () {
    int t;
    scanf("%d", &t);

    int segment_id = shmget(IPC_PRIVATE, ARRAY_SIZE * sizeof(int),
                         IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR);
    int * shared_memory = (int *) shmat(segment_id, 0, 0);

    pid_t plus_pid = fork();
    if (plus_pid == 0) {
        while (1) {
            shared_memory[random_number(0, ARRAY_SIZE)]++;
        }
    } else {
        alarm(t);

        kill_pid = plus_pid;
        signal(SIGALRM, handle_alarm);

        while (!done_flag) {
            shared_memory[random_number(0, ARRAY_SIZE)]--;
        }
    }

    for (int i = 0; i < ARRAY_SIZE; i++) {
        printf("%d ", shared_memory[i]);
    }
    printf("\n");

    shmdt(shared_memory);
    shmctl(segment_id, IPC_RMID, 0);

    return 0;
}

