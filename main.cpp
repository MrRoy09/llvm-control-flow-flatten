#include <iostream>
int main(){
    int y;
    scanf("%d", &y);
    int x =50;
    printf("we outside the loop\n");
    for(;y<100;y++){
        printf("%d\n",y);
    }
    printf("%d\n",y);
    return y;
}
