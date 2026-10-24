#include <stdio.h>
#include <xenos/xenos.h>
#include <console/console.h>

int main() {
    xenos_init(VIDEO_MODE_AUTO);
    console_init();
    printf("Ola, StumbleXbox!\n");
    while (1) {}
    return 0;
}
