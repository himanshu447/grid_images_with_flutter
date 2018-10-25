class City {
  final String name;

  final String image;

  final String population;

  final String countery;

  City({this.name, this.countery, this.image, this.population});

  static List<City> allCities() {
    var lstOfCities = new List<City>();

    lstOfCities.add(new City(
        name: "Delhi",
        countery: "India",
        population: "19 mill",
        image: "delhi.png"));
    lstOfCities.add(new City(
        name: "London",
        countery: "Britain",
        population: "8 mill",
        image: "london.png"));
    lstOfCities.add(new City(
        name: "Vancouver",
        countery: "Canada",
        population: "2.4 mill",
        image: "vancouver.png"));
    lstOfCities.add(new City(
        name: "New York",
        countery: "USA",
        population: "8.1 mill",
        image: "newyork.png"));
    lstOfCities.add(new City(
        name: "Paris",
        countery: "France",
        population: "2.2 mill",
        image: "paris.png"));
    lstOfCities.add(new City(
        name: "Berlin",
        countery: "Germany",
        population: "3.7 mill",
        image: "berlin.png"));

    return lstOfCities;
  }
}
