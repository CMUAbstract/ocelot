#include <stdio.h>

void Fresh(int x) {}
void Consistent(int x, int id) {}

void atomic_start() {}
void atomic_end() {}

int sense() { return 0; }
int (*IO_NAME)() = sense;

int norm(int t) { return t; }

void log(int x) {
  printf("%d\n", x);
}

int tmp() {
  int t = sense();
  int t_norm = norm(t);
  return t_norm;
}

void app() {
  int x = tmp();
  Fresh(x);
  log(x);
}

int main() {
  app();
}