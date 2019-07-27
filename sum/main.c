#include <stdio.h>

extern int sum(int n);

void main(){
    int n,result;
    n=10;
    result = sum(n);
    printf("result = %d\n",result);
}
