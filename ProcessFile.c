#include <stdio.h>

void process_file(char *filename);

int main(int argc, char *argv[])
{
	if (argc != 2) {
		printf("Usage: ./Tutorial7 filename\n");
	} else {
		process_file(argv[1]);
	}
}

void process_file(char *filename){
	FILE *file;
	char name[10];
	float mark1, mark2, mark3;
	float average;
	file = fopen(filename, "r");
	while (fscanf(file, "%s %f,%f,%f", name, &mark1, &mark2, &mark3) != EOF) {
		average = (mark1 + mark2 + mark3) / 3;
		printf("Average mark for %s = %f\n", name, average);
	}
	fclose(file);
}
