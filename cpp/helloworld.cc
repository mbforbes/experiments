#include <iostream>
#include <cstdlib>
#include <iomanip>

using namespace std;

int main(int argc, char **argv) {
  string in;
  // setw only affects next thing sent to output stream
  cout << "Hi! " << setw(4) << 5 << " " << 5 << endl;
  cout << hex << 16 << " " << 13 << endl;
  // hex stays in effect even for this next line -- until we set dec...
  cout << "still hex! " << 16 << " " << dec << 16 << " " << 13 << endl;
  cout << "Gimmie a number: ";
  cin >> in;
  cout << "Not sure if that was a number, but you gave: " << in << endl;
  
  return EXIT_SUCCESS;
}
