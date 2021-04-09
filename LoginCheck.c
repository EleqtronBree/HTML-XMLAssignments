#include <stdio.h>
#include <string.h>

void make_new_name(char *new_name, char *original_name);
int length_of_password(char *password);
int is_alpha(char c);
int is_digit(char c);
int is_valid_password(char *password);
void perform_XOR(char *input_filename, char *output_filename, char *password);
void print_first_five(char *filename);

int main(int argc, char *argv[]) {
	if (argc != 3) {
		printf("Usage: %s filename password\n", argv[0]);
	} else {
		char new_name[30] = "new-";
		make_new_name(new_name, argv[1]);
		printf("Password length = %d\n", length_of_password(argv[2]));
		if (is_valid_password(argv[2]) == 1) {
			perform_XOR(argv[1], new_name, argv[2]);
			print_first_five(new_name);
		}
	}
	return 1;
}

void make_new_name(char *new_name, char *original_name) {
	strcat(new_name, original_name);
	printf("New filename = %s\n", new_name);
}

int length_of_password(char *password) {
	return strlen(password);
}

int is_alpha(char c) {
	if ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z')) {
		return 1;
	} 
	return 0;
}

int is_digit(char c) {
	if (c >= '0' && c <= '9') {
		return 1;
	} 
	return 0;
}

int is_valid_password(char *password) {
	int has_alpha = 0;
	int has_digit = 0;
	int is_valid = 1;
	// check if password is less than 8 characters
	if (length_of_password(password) < 8) {
		printf("The password needs to have at least 8 characters.\n");
		is_valid = 0;
	}
	// find letter and digit in password array
	for (int i = 0 ; i < length_of_password(password); i++) {
		if (is_digit(*(password + i)) == 1) {
			has_digit = 1;
		} else if (is_alpha(*(password + i)) == 1) {
			has_alpha = 1;
		}
	}
	// check if letter or digit exists
	if (has_digit == 0) {
		printf("The password needs to contain at least 1 digit.\n");
		is_valid = 0;
	}
	if (has_alpha == 0) {
		printf("The password needs to contain at least 1 alphabetical character.\n");
		is_valid = 0;
	}
	if (is_valid == 1) {
		return 1;
	}
	return 0;
}

void perform_XOR(char *input_filename, char *output_filename, char *password) {
	FILE *file, *new_file;
	int block_size = length_of_password(password);
	char block[block_size];
	int num_bytes;
	file = fopen(input_filename, "rb");
	new_file = fopen(output_filename, "wb");
	
	// read in a block of data
	do {
		num_bytes = fread(block, 1, block_size, file);
		for (int i = 0; i < num_bytes; i++) {
			block[i] = block[i] ^ password[i];
		}
		fwrite(block, 1, num_bytes, new_file);
	} while (num_bytes == block_size);
	fclose(file);
	fclose(new_file);
}

void print_first_five(char *filename) {
	FILE *file;
	file = fopen(filename, "rb");
	// read first 5 bytes
	for (int i = 0; i < 5; i++) {
		unsigned char byte = 0;
		fread(&byte, 1, 1, file);
		printf("%x\n", byte);
	}
	fclose(file);
}