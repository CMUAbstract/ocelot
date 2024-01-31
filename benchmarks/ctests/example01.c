#include <stdio.h>

void Fresh(int x) { printf("Fresh\n"); }
void Consistent(int x, int id) { printf("Consistent\n"); }

void atomic_start() {}
void atomic_end() {}

int tmp() { return 0; }
int (*IO_NAME1)() = tmp;

void log(int x) {
  printf("%d\n", x);
}

int app() {
  int x = tmp();
  Fresh(x);
  log(x);
  return 0;
}

int main() {
  app();
}