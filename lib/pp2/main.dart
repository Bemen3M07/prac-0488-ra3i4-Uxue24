import 'package:flutter/material.dart'; // Main Dart File
import 'package:provider/provider.dart'; // State Management
import 'providers/moto_provider.dart'; // Importa el provider de motos
import 'pages/seleccio_pagina.dart'; // Importa la página de selecció

void main() { // Punt d'entrada de l'aplicació
  runApp( // Executa l'aplicació
    ChangeNotifierProvider( // Proveïdor per a la gestió d'estat
      create: (_) => MotoProvider(), // Crea una instància del MotoProvider
      child: const MainApp(), // Widget principal de l'aplicació
    ),);}

class MainApp extends StatelessWidget { // Widget principal de l'aplicació
  const MainApp({super.key}); // Constructor
  @override
  Widget build(BuildContext context) { // Construcció de la UI
    return MaterialApp( // Widget d'aplicació material
      title: "App Motos", // Títol de l'aplicació
      debugShowCheckedModeBanner: false, // Desactiva la bandera de depuració
      home: const SeleccioPagina(), // Página inicial de l'aplicació
      );}}
