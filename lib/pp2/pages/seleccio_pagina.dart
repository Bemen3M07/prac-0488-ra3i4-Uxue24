import 'package:flutter/material.dart'; // Pàgina de selecció
import 'package:pp2/pp2/model/moto.dart'; // Model de Moto
import 'package:provider/provider.dart'; // Gestió d'estat
import '../providers/moto_provider.dart'; // Proveïdor de motos
import 'resultat_pagina.dart'; // Pàgina de resultats

class SeleccioPagina extends StatelessWidget { // Página de selecció
  const SeleccioPagina({super.key}); // Constructor
  @override
  Widget build(BuildContext context) { // Construcció de la UI
    final provider = Provider.of<MotoProvider>(context); // Obté el proveïdor de motos
    return Scaffold( 
      backgroundColor: const Color(0xFFADD8E6), // FONDO AZUL CLARO
      appBar: AppBar( // Barra d'aplicació 
        title: const Text("Selecció de Moto"), // Títol
        backgroundColor: const Color.fromARGB(255, 200, 130, 212), // COLOR DE FONDO MORADO
        foregroundColor: Colors.white,  // COLOR DEL TEXTO BLANCO
      ),
      body: Center(  // TODO CENTRADO
        child: Column( // Columna para organizar widgets verticalmente
          mainAxisAlignment: MainAxisAlignment.center, // Centrado verticalmente
          children: [
            DropdownButton<Moto>( // Menú desplegable para seleccionar moto
              value: provider.motoSeleccionada, // Moto seleccionada actualmente
              hint: const Text("Selecciona una moto", style: TextStyle(fontSize: 18)),
              items: provider.motos.map((m) { // Mapea la lista de motos a elementos del menú
                return DropdownMenuItem( // Elemento del menú desplegable
                  value: m, // Valor del elemento
                  child: Text(m.marcaModelo), // Muestra la marca y modelo de la moto
                );
              }).toList(), // Convierte el iterable a lista
              onChanged: (m) => provider.seleccionarMoto(m), // Maneja el cambio de selección
            ),
            const SizedBox(height: 25), // Espacio entre elementos
            ElevatedButton(
              style: ElevatedButton.styleFrom( // Estilo del botón
                backgroundColor: const Color.fromARGB(255, 212, 153, 223), // COLOR DE FONDO MORADO
                foregroundColor: Colors.white, // COLOR DEL TEXTO BLANCO
                padding: const EdgeInsets.symmetric( 
                    horizontal: 30, vertical: 15),  // Relleno del botón
              ),
              onPressed: provider.motoSeleccionada == null // Deshabilita el botón si no hay moto seleccionada
                  ? null
                  : () {
                      Navigator.push( // Navega a la página de resultados
                        context, 
                        MaterialPageRoute( 
                          builder: (_) => const ResultatPagina(), // Página de resultados
                        ),
                      );
                    },
              child: const Text("Continuar", style: TextStyle(fontSize: 18)), // Texto del botón
            ),],),),);}}
