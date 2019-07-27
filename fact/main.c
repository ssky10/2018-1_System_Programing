#include <stdio.h>

extern int fact(int n);

void main(){
    int n,result;
    n=10;
    result = fact(n);
    printf("result = %d\n",result);
}
