#include <sys/types.h>
#include <dirent.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

// Helper function to check if a struct dirent from /proc is a PID folder.
int is_pid_folder(const struct dirent *entry) {
    const char * p;
    for (p = entry->d_name; *p; p++) {
        if (!isdigit(*p)) {
            return 0;
		}
    }

    return 1;
}

int main(void) {
    struct dirent *entry;
    char path[256 + 5 + 7]; // d_name + /proc + /status
    int pid = -1;
    unsigned long vm_size = 0;

    // Open /proc directory.
    DIR *procdir = opendir("/proc");
    if (!procdir) {
        perror("opendir failed");
        return 1;
    }

    // Iterate through all files and folders of /proc.
    while ((entry = readdir(procdir))) {
        // Skip anything that is not a PID folder.
        if (!is_pid_folder(entry)) {
            continue;
		}

        // Try to open /proc/<PID>/status.
        snprintf(path, sizeof(path), "/proc/%s/status", entry->d_name);
        FILE *fp = fopen(path, "r");
        if (!fp) {
            perror(path);
            continue;
        }

        size_t len = 128;
		char * line = malloc(len);
		char * vmsize = NULL;
        int found_info = 1;
		while (!vmsize) {
			/* File have no memory usage information */
			if (getline(&line, &len, fp) == -1) {
                found_info = 0;
                break;
            }
            if (!strncmp(line, "VmSize:", 7)) {
                vmsize = strdup(&line[0]);
            }
        }
        free(line);
        
        if (found_info) {
            size_t length = strlen(vmsize) - strlen(" kB\n");
            size_t index = strlen("VmSize:");
            while (index < length && isspace(vmsize[index])) {
                index++;
            }
            const unsigned long result = strtoul(vmsize + index, (char **) &vmsize[length], 10);
            if (result > vm_size) {
                vm_size = result;
                pid = atoi(entry->d_name);
            }
        }
		free(vmsize);
        fclose(fp);
    }

    printf("PID:\t %d\n", pid);
    printf("VmSize:\t %lu\n", vm_size);
    closedir(procdir);
    
    return 0;
}
