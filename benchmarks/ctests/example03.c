#include <stdio.h>

void Fresh(int x) {}
void Consistent(int x, int id) {}

void atomic_start() {}
void atomic_end() {}

int input() { return 0; }
int (*IO_NAME)() = input;

void log(int x) {
  printf("%d\n", x);
}

void app() {
  int x = input();
  int y = 1;
  int z = y + 1;
  log(z);
  log(x);
  Fresh(x);
}

int main() {
  app();
}