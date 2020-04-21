#include <iostream>
#include <vector>
using namespace std;

struct Car {
  string brand;
  int year, passengers;
  double consumption;
};

int main() {
	cout << "Good morning everyone! We are learning about structs in C++.";
  int n;
  cin >> n;
  
  /* Simple, bit ugly solution
  string brand[n];
  int year[n], passengers[n];
  for (int i = 0; i < n; i++) {
    cin >> brand[i] >> year[i] >> passengers[i];
  }*/
  
  // Something much better
  Car cars[n];
  for (int i = 0; i < n; i++) {
    cin >> cars[i].brand >> cars[i].year >> cars[i].passengers;
  }
  for (int i = 0; i < n; i++) {
    cout << "brand: " << cars[i].brand << ", year: " << cars[i].year
         << ", passengers: " << cars[i].passengers << endl;
  }
  
  int whatever = 5;
  
  Car myCar; // Type variable_name;
  myCar.brand = "Audi"; // variable_name.member = value;
  myCar.year = 2000;
  myCar.passengers = 5;
  myCar.passengers++;
  myCar.year -= 2;
  cout << "brand: " << myCar.brand << ", year: " << myCar.year
         << ", passengers: " << myCar.passengers << endl;
         
  Car myTruck{"Volvo", 2001, 25};
  myTruck.consumption = 20.5;
  cout << "brand: " << myTruck.brand << ", year: " << myTruck.year
         << ", passengers: " << myTruck.passengers
         << ", consumption: " << myTruck.consumption  << endl;
         
  vector<Car> vec;
  vec.push_back(myCar);
  vec.push_back(myTruck);
  
  vector<int> yearsOfCars;
  yearsOfCars.push_back(myCar.year);
	return 0;
}
