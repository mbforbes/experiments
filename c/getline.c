#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <assert.h>

static char *GetNextLine(FILE *f);

int main(int argc, char **argv) {
  char *lineptr = NULL;
  char *firstword;
  lineptr = GetNextLine(stdin);
  assert(lineptr != NULL);

  printf("string: %s\nlength: %d\n", lineptr, strlen(lineptr));
  firstword = strtok(lineptr, " ");
  printf("first word: %s\n", firstword);
  free(lineptr);
  return 1;
}


// This utility function reads the next line from file F
// into a C string in heap-allocated memory and returns a pointer
// to it.  A line is defined to be zero or more characters that
// end at a either a newline character or the end of the file.
//
// If the line ends with a newline character ('\n'), the
// newline character is discarded (overwritten with '\0').  Therefore,
// this function will return an empty string (just the '\0')
// if it encounters an empty line in the file.
//
// On error, returns NULL.  Caller is responsible for
// fclose()'ing the file; this function never does that.
static char *GetNextLine(FILE *f) {
  char *retbuf = NULL;
  int retlen = 0;
  int toread = 10; // read this many characters each iteration
  int numread = 0;
  int done = 0;

  // STEP 1 -- implement GetNextLine().  I recommend using
  // fgets() and realloc() to do it.  (fgets() to read some
  // number of characters per loop iteration, and realloc
  // to grow the buffer you're reading into on each loop
  // iteration.)  You can use whatever loop construct you
  // like; I like using while (!done) { .. }, but you can
  // do something else if it makes sense to do so.
  while (!done) {
	if (fgets(retbuf, toread, f) == NULL) {
	  // nothing read - reached end of file on this iteraton
	  done = 1;
	} else {
	  numread = strlen(loopbuff);
	  // check for and take care of \n
	  if (loopbuff[numread - 1] == '\n') {
		loopbuff[numread - 1] = '\0';
		--numread;
		done = 1;
	  }
	  // see if less read then full capacity (thus done reading)
	  if (numread < toread - 1) {
		done = 1;
	  }
	  // realloc and append the amount read
	  retlen += numread;
	  retbuf = realloc(retbuf, retlen);
	}
  }
  return retbuf;
}
