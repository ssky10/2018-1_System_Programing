#include <stdio.h>

extern int max(int a, int b);

void main(){
    int n,m,result;
    n=3;
    m=4;
    result = max(n,m);
    printf("result = %d\n",result);
}
