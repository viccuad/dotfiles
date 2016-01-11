#include <stdio.h>
#include <stdlib.h>

/* Licence: Public Domain. */
/* TODO: improve the code. */

int main(int argc, char **argv){
    if(argc == 1)
        printf("Hello World!\n");
    else
        fprintf(stderr, "What is '%s'?\n",
              argv[1]);
    return 0;
}
