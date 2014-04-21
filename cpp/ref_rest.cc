#include <iostream>
#include <cstdlib>

using namespace std;

void swap(int &x,int &y) {
  int tmp = x;
  x = y;
  y = tmp;
}

int main(int argc, char **argv) {
  int x = 5;
  int y = 10;
  
  cout << "Before: x=" << x << ", y=" << y << endl;
  swap(x, y);
  cout << "After: x=" << x << ", y=" << y << endl;
  
  return EXIT_SUCCESS;
}
