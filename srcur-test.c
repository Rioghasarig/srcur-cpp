#include "lusol.h"
#include "lusolio.h"
#include <time.h>
#include <stdlib.h>

#define BASE 1


int main()
{
  srand(time(NULL));
  REAL* Aij = 0; 
  int* iA = 0; int* jA =0;
  int maxm, maxn;
  int m, n, nnzero;
  int maxnz = 30000;


  if(!ctf_size_A("Afile3.txt", &maxm, &maxn, &maxnz))
  {
     printf("Error Getting Matrix Dimensions\n");
     return -1; 
  }
  Aij = (REAL *) calloc(maxnz + BASE, sizeof(REAL));
  iA = (int *)   calloc(maxnz + BASE, sizeof(int));
  jA = (int *)   calloc(maxnz + BASE, sizeof(int));

  
  if(!ctf_read_A("Afile3.txt", maxm, maxn, maxnz,
		 &m, &n, &nnzero, iA,jA, Aij))
  {
    printf("Error Reading File\n");
    return -1;
  }
  FILE *outunit = stdout;
  int inform;
  
  LUSOLrec *LUSOL = NULL;
  LUSOL = LUSOL_create(outunit, 0, LUSOL_PIVOT_TPP, 0);
  if(!LUSOL_assign(LUSOL, iA, jA, Aij, nnzero, TRUE))
  {  
    fprintf(outunit, "Error: LUSOL failed due to insufficient memory.\n");
    return -1;
  }
  LU1FAC( LUSOL, &inform); 
  return 0;
}
