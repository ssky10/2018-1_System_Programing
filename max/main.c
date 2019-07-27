#include <stdio.h>

extern void max(int a, int b);
int result;

void main(){
    int n,m;
    n=3;
    m=4;
    max(n,m);
    printf("result = %d\n",result);
}
