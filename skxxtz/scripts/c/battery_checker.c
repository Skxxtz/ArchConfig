#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

void notify(char *summary, char *message);
int battery_checker();
bool is_notified();
void reset_file();

int main() {
    return battery_checker();
}

void notify(char *summary, char *message){
    char command[256];
    const char *filename = "/tmp/battery_notification_triggered";
    FILE *file = fopen(filename, "w");

    snprintf(command, sizeof(command), "notify-send -u critical -i '/home/basti/.config/skxxtz/icons/power-warning.svg' '%s' '%s' --app-name 'Power Management'", summary, message);
    system(command);

    if(file != NULL){
        fputc('1', file);
        fclose(file);
    }
}

int battery_checker(){
    const char *filePath = "/sys/class/power_supply/BAT0/capacity";
    FILE *file = fopen(filePath, "r");

    if (file == NULL) {
        perror("Error opening file");
        return EXIT_FAILURE;
    }

    char fileContent[4]; // Assuming battery percentage is a small integer (0-100)
    if (fgets(fileContent, sizeof(fileContent), file) == NULL) {
        perror("Error reading file");
        fclose(file);
        return EXIT_FAILURE;
    }

    fclose(file);

    int percentage = atoi(fileContent);
    if ((percentage < 10) && (is_notified() == 0)) {
        notify("Low Battery", "Battery level is below 10%");
    } else if (percentage > 10) {
        reset_file();
    }

    return EXIT_SUCCESS;
}

bool is_notified(){
    FILE *file;
    const char *filename = "/tmp/battery_notification_triggered";
    char ch;

    file = fopen(filename, "r");
    if(file == NULL){
        file = fopen(filename, "w");
        if (file == NULL){
            perror("Error creating file");
            return false;
        }
        fputc('0', file);
        fclose(file);
        return false;
    }

    ch = fgetc(file);
    fclose(file);

    return (ch == '1');
}

void reset_file(){
    FILE *file;
    const char *filename = "/tmp/battery_notification_triggered";
    
    file = fopen(filename, "w");
    if(file == NULL){
        perror("Error creating file");
        return;
    }

    fputc('0', file);
    fclose(file);
}
