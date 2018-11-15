#include <stdio.h>
#include <stdlib.h>
// compile and then run 'floppy image.bin mbr.bin payload.bin' 
/* 80 tracks, 18 sectors per track, 512 bytes per sector, 2 sides
 * (https://support.microsoft.com/en-us/kb/121839)
 */
#define FLOPPY_SIZE (80 * 18 * 512 * 2)

/* Open <next_input_file> for reading, concatenate its contents
 * to the stream <output>, and return the number of bytes written.
 */
int add_file(FILE *output, const char *next_input_file) {
    FILE *input = NULL;
    int size = 0, xfer;
    char buffer[512];
    
    if ((input = fopen(next_input_file, "rb")) == NULL) {
        perror("unable to open input file");
        size = -1;
        goto cleanup;
    }
    
    while ((xfer = fread(buffer, 1, sizeof(buffer), input)) > 0) {
        if (fwrite(buffer, 1, xfer, output) != xfer) {
            perror("error writing to output file");
            size = -1;
            goto cleanup;
        }
        size += xfer;
    }
    if (xfer < 0) {
        perror("error reading from input file");
        size = -1;
    }
    
cleanup:
    if (input) { fclose(input); }
    return size;
}

int main(int argc, char **argv) {
    FILE *output = NULL;
    int i, size, total, ret = 1;
    
    if (argc < 2) {
        fputs("usage: mkfloppy OUTPUT_FILE [MBR_FILE [PAYLOAD_FILE1 [...]]]", stderr);
        goto cleanup;
    }
    
    if ((output = fopen(argv[1], "wb")) == NULL) {
        perror("unable to open output file");
        goto cleanup;
    }
    
    total = 0;
    for (i = 2; i < argc; ++i) {
        if ((size = add_file(output, argv[i])) < 0) {
            goto cleanup;
        }
        total += size;
    }
    
    while (total < FLOPPY_SIZE) {
        putc(0, output);
        ++total;
    }
    
cleanup:
    if (output) { fclose(output); }
    return 0;
}