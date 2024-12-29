#include <iostream>
int main(){
    int y;
    scanf("%d", &y);
    int x =50;
    printf("we outside the loop\n");
    while(y<100){
        printf("we in the loop\n");
        if(y==10){
            printf("we in the subcase 10\n");
            y+=1;
            x+=10;
        }
        else if(y==11){
            printf("we in the subcase 11\n");
            y+=2;
            x-=10;
        }
        else{
            printf("we in the else subcase\n");
            y+=3;
            x-=20;
        }
    }
    printf("%d\n",y);
    return y;
}
