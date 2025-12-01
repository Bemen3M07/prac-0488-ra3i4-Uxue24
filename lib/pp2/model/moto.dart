class Moto { // MODEL DE MOTO
  final String marcaModelo; // MARCA I MODEL
  final double fuelTankLiters; // CAPACITAT DEL DIPÒSIT EN LITRES
  final double consumptionL100; // CONSUM EN L/100KM
  Moto({ // CONSTRUCTOR
    required this.marcaModelo, // MARCA I MODEL
    required this.fuelTankLiters, // CAPACITAT DEL DIPÒSIT EN LITRES
    required this.consumptionL100, // CONSUM EN L/100KM
  });
  double get autonomiaKm => (fuelTankLiters / consumptionL100) * 100; // AUTONOMIA EN KM
}
