#include <stdio.h>

void Fresh(int x) {}
void Consistent(int x, int id) {}

void atomic_start() {}
void atomic_end() {}

int input(int i) { return i; }
int (*IO_NAME)() = input;

void log(int x) {
  printf("%d\n", x);
}

void app() {
  int i = 1;
  int x = input(i);
  Fresh(x);
  log(x);
}

int main() {
  app();
}