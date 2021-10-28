#include <stdio.h>
#include <string.h>
#include <proc/readproc.h>

int main() {
    PROCTAB* proc = openproc(PROC_FILLSTATUS);
    proc_t proc_info;
    memset(&proc_info, 0, sizeof(proc_info));
    int max_pid = 0;
    unsigned long max_vm_size = 0;
    while (readproc(proc, &proc_info) != NULL) {
        if (proc_info.vm_size > max_vm_size) {
            max_vm_size = proc_info.vm_size;
            max_pid = proc_info.tgid;
        }
    }
    printf("PID:\t %d\n", max_pid);
    printf("VmSize:\t %lu\n", max_vm_size);
    closeproc(proc);

    return 0;
}