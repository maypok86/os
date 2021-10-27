#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <proc/readproc.h>

// compile with:
// gcc environ.c -lprocps -o bin/environ
int main(){

  PROCTAB* proc = openproc(PROC_FILLSTAT);
  proc_t proc_info;
  memset(&proc_info, 0, sizeof(proc_info));
  while (readproc(proc, &proc_info) != NULL) {
    printf("%i,%i:\t %lu\n", proc_info.ppid, proc_info.tid, proc_info.maj_flt);
  }
  closeproc(proc);
}

