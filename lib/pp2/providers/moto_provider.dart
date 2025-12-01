import 'package:flutter/material.dart'; // Proveïdor de motos
import '../model/moto.dart'; // Model de Moto

class MotoProvider extends ChangeNotifier { // Proveïdor de motos
  // LISTA OFICIAL DEL PROFESOR
  final List<Moto> motos = [  // Llista de motos disponibles
    Moto( // MODEL DE MOTO
        marcaModelo: 'Honda PCX 125',  // MARCA I MODEL
        fuelTankLiters: 8.0, // CAPACITAT DEL DIPÒSIT EN LITRES
        consumptionL100: 2.1), // CONSUM EN L/100KM
    Moto(  
        marcaModelo: 'Yamaha NMAX 125', // MARCA I MODEL
        fuelTankLiters: 7.1, // CAPACITAT DEL DIPÒSIT EN LITRES
        consumptionL100: 2.2), // CONSUM EN L/100KM
    Moto(
        marcaModelo: 'Kymco Agility City 125', // MARCA I MODEL
        fuelTankLiters: 7.0, // CAPACITAT DEL DIPÒSIT EN LITRES
        consumptionL100: 2.5), // CONSUM EN L/100KM
    Moto(
        marcaModelo: 'Piaggio Liberty 125', // MARCA I MODEL
        fuelTankLiters: 6.0, // CAPACITAT DEL DIPÒSIT EN LITRES
        consumptionL100: 2.3), // CONSUM EN L/100KM
    Moto(
        marcaModelo: 'Sym Symphony 125', // MARCA I MODEL
        fuelTankLiters: 5.5, // CAPACITAT DEL DIPÒSIT EN LITRES
        consumptionL100: 2.4), // CONSUM EN L/100KM
    Moto(
        marcaModelo: 'Vespa Primavera 125', // MARCA I MODEL
        fuelTankLiters: 8.0, // CAPACITAT DEL DIPÒSIT EN LITRES
        consumptionL100: 2.8), // CONSUM EN L/100KM
    Moto(
        marcaModelo: 'Kawasaki J125', // MARCA I MODEL
        fuelTankLiters: 11.0, // CAPACITAT DEL DIPÒSIT EN LITRES
        consumptionL100: 3.5), // CONSUM EN L/100KM
    Moto(
        marcaModelo: 'Peugeot Pulsion 125', // MARCA I MODEL
        fuelTankLiters: 12.0, // CAPACITAT DEL DIPÒSIT EN LITRES
        consumptionL100: 3.0), // CONSUM EN L/100KM
  ];
  Moto? _motoSeleccionada; // Moto seleccionada actual
  Moto? get motoSeleccionada => _motoSeleccionada; // Getter per a la moto seleccionada
  double? kmInicialGuardado; // Km inicial guardat
  double? kmActualGuardado; // Km actual guardat
  void seleccionarMoto(Moto? moto) { // Selecciona una moto
    _motoSeleccionada = moto; // Assigna la moto seleccionada
    // SI CAMBIO DE MOTO → LOS CAMPOS DEBEN QUEDAR VACÍOS
    kmInicialGuardado = null; // Reseteja el km inicial guardado
    kmActualGuardado = null; // Reseteja el km actual guardado
    notifyListeners(); // Notifica als oients del canvi
  }
  void guardarKmInicial(double valor) { 
    kmInicialGuardado = valor; // Guarda el km inicial
    notifyListeners(); // Notifica als oients del canvi
  }
  void guardarKmActual(double valor) {
    kmActualGuardado = valor; // Guarda el km actual
    notifyListeners(); // Notifica als oients del canvi
  }
  double calcularKmRestantes(double kmInicial, double kmActual) {
    if (_motoSeleccionada == null) return 0; // Si no hi ha moto seleccionada, retorna 0
    double kmHechos = kmActual - kmInicial; // Calcula els km fets
    double autonomia = _motoSeleccionada!.autonomiaKm; // Obtén l'autonomia de la moto seleccionada
    return autonomia - kmHechos; // Retorna els km restants
  }}
