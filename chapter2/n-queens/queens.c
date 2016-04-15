#include<stdio.h>
#include<stdbool.h>
#include<stdlib.h>
#include"queens.h"

int row_positions[50];

int no_of_solutions = 0;

void print_final_result() {
    printf("Total number of solutions found: %i\n", no_of_solutions);
    printf("\n");
    printf("Finally, I get backtracking.\n");
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("One argument is mandatory.\n");
        return 1;
    }

    int board_size = atoi(argv[1]);

    if (board_size == 0) {
        printf("Either the argument was not a valid number or you entered 0.\n");
        return 1;
    }

    queen_cols(1, board_size);

    print_final_result();

    return 0;
}

bool safe(int new_col, int new_row) {
    for (int col=1; col<=new_col-1; col++) {
        if (row_positions[col] == new_row || abs(new_col - col) == abs(new_row - row_positions[col])) {
            return false;
        }
    }
    return true;
}


void queen_cols(int k, int board_size) {  // k for col
    for (int row = 1; row <= board_size; row++) {
        if (safe(k, row)) {
            row_positions[k] = row;
            if (k == board_size) {
                handle_found_solution(board_size);
            } else {
                queen_cols(k+1, board_size);
            }
        }
    }
}

void handle_found_solution(int board_size) {
    no_of_solutions++;

    printf("Solution %i:\n", no_of_solutions);
    for (int i=1; i<=board_size; i++) {
        printf("%i ", row_positions[i]);
    }
    printf("\n\n");
}
