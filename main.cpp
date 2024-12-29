#include <iostream>
int main(){
    int y;
    scanf("%d", &y);
    int x =50;
    while(y<100){
        if(y==10){
            y+=1;
            x+=10;
        }
        else if(y==11){
            y+=2;
            x-=10;
        }
        else{
            y+=3;
            x-=20;
        }
    }
    printf("%d",y);
    return y;
}
