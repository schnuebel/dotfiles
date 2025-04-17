#include <stdio.h>
#include <string.h>
#include <math.h>

// gcc color-picker.c -lm -o color-picker
int main(int argc, char** argv) {

    if(argc < 2) {
        return 0;
    }

    char* input = argv[1];
    int input_size = strlen(input);

    int total = 0;
    for(int i = 0; i < input_size; i++){
        total += input[i];
    }

    int r = (total * 4200) % 256;
    int g = (total * 1337) % 256;
    int b = (total * 1234) % 256;

    char background[30];
    sprintf(background,"#%02x%02x%02x",r,g,b);
    printf("%s\n", background);

    //https://gamedev.stackexchange.com/questions/38536/given-a-rgb-color-x-how-to-find-the-most-contrasting-color-y
    float gamma = 2.2;
    float R = (float)r/255;
    float G = (float)g/255;
    float B = (float)b/255;
    float luminance = 0.2126 * powf( R, gamma )
        + 0.7152 * powf( G, gamma )
        + 0.0722 * powf( B, gamma );
    int use_black = (luminance > powf(0.5, gamma));

    char BLACK[30] = "#000000";
    char WHITE[30] = "#FFFFFF";
    if(use_black){
       printf("%s\n", BLACK); 
    } else {
       printf("%s\n", WHITE); 
    }

}
