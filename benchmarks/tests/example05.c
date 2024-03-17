#include <stdio.h>

void Fresh(int x) {}

void atomic_start() {}
void atomic_end() {}

int input() { return 0; }
int (*IO_NAME)() = input;

void log(int x) {
  printf("%d\n", x);
}

void app() {
  int x = input();
  for (int i = 0; i < 10; i++) {
    log(1);
    log(x);
  }
  // for (int i = 0; i < 10; i++) {
  //   log(1);
  // }
  Fresh(x);
}

int main() {
  app();
}