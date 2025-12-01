import 'package:flutter/material.dart'; // Página de resultats
import 'package:flutter/services.dart'; // Per a la formatació d'entrada
import 'package:provider/provider.dart'; // Gestió d'estat
import '../providers/moto_provider.dart'; // Proveïdor de motos

class ResultatPagina extends StatefulWidget { // Página de resultats
  const ResultatPagina({super.key}); // Constructor
  @override
  State<ResultatPagina> createState() => _ResultatPaginaState(); // Crea l'estat
}
class _ResultatPaginaState extends State<ResultatPagina> { // Estat de la página de resultats
  final kmInicialController = TextEditingController(); // Controlador per al km inicial
  final kmActualController = TextEditingController(); // Controlador per al km actual
  String? errorText; // text d'error mostrada a l'UI
  double? resultat; // resultat del càlcul
  @override
  void initState() { // Inicialització de l'estat
    super.initState(); // Crida al mètode pare
    final provider = Provider.of<MotoProvider>(context, listen: false); // Obté el proveïdor de motos
    // Cargar valores guardados
    if (provider.kmInicialGuardado != null) { // Si hi ha km inicial guardat
      kmInicialController.text = provider.kmInicialGuardado!.toString(); // Assigna el valor al controlador
    }
    if (provider.kmActualGuardado != null) { // Si hi ha km actual guardat 
      kmActualController.text = provider.kmActualGuardado!.toString(); // Assigna el valor al controlador
    }
    // Guardar cambios y recalcular automáticamente
    kmInicialController.addListener(() { // Escucha cambios en el km inicial
      final v = double.tryParse(kmInicialController.text); // Intenta parsear el valor
      if (v != null) provider.guardarKmInicial(v); // Guarda el valor si es válido
      recalcular(); // Recalcula el resultado
    });
    kmActualController.addListener(() { // Escucha cambios en el km actual
      final v = double.tryParse(kmActualController.text); // Intenta parsear el valor
      if (v != null) provider.guardarKmActual(v); // Guarda el valor si es válido
      recalcular(); // Recalcula el resultado
    });
  }
  @override 
  void dispose() { 
    kmInicialController.dispose(); // Libera recursos del controlador
    kmActualController.dispose(); // Libera recursos del controlador
    super.dispose(); // Crida al mètode pare
  }
  // recalcular sin pulsar botón
  void recalcular() {
    final textIni = kmInicialController.text.trim(); // Elimina espacios en blanco
    final textAct = kmActualController.text.trim(); // Elimina espacios en blanco
    final kmIni = double.tryParse(textIni); // Intenta parsear el valor
    final kmAct = double.tryParse(textAct); // Intenta parsear el valor
    if (kmIni == null || kmAct == null) return; // Si no son válidos, sale
    final provider = Provider.of<MotoProvider>(context, listen: false); // Obté el proveïdor de motos
    final calc = provider.calcularKmRestantes(kmIni, kmAct);  // Calcula el resultado
    setState(() {
      resultat = calc < 0 ? 0.0 : calc; // actualiza el resultado
      errorText = null; // limpia errores en cuanto los datos son válidos
    });
  }
  void calcular() { 
    // (tu función sigue igual, ya no es imprescindible pero la dejo como está)
    setState(() {
      errorText = null; // Limpia el texto de error
      resultat = null; // Limpia el resultado
    });
    final textIni = kmInicialController.text.trim(); // Elimina espacios en blanco
    final textAct = kmActualController.text.trim(); // Elimina espacios en blanco
    if (textIni.isEmpty || textAct.isEmpty) { // Si alguno está vacío
      setState(() { 
        errorText = "Has dintroduir valors km quan vas omplir i km actuals."; // Mensaje de error
      }); return; }
    final kmIni = double.tryParse(textIni); // Intenta parsear el valor
    final kmAct = double.tryParse(textAct); // Intenta parsear el valor
    if (kmIni == null || kmAct == null) { 
      setState(() { 
        errorText = "Introdueix nUmeros vAlids nomEs dIgits i punt decimal."; // Mensaje de error
      }); return;}
    if (kmAct < kmIni) { 
      setState(() { 
        errorText = "El km actual no pot ser menor que els km que tenia quan vas omplir el dipOsit."; // Mensaje de error
      }); return;}
    final provider = Provider.of<MotoProvider>(context, listen: false); // Obté el proveïdor de motos
    final calc = provider.calcularKmRestantes(kmIni, kmAct); // Calcula el resultado
    setState(() {
      resultat = calc < 0 ? 0.0 : calc; // Actualiza el resultado
    });
  }
  @override
  Widget build(BuildContext context) { // Construcció de la UI
    final provider = Provider.of<MotoProvider>(context); // Obté el proveïdor de motos
    final moto = provider.motoSeleccionada!; // Obté la moto seleccionada
    return Scaffold( 
      backgroundColor: const Color(0xFFADD8E6), // FONDO AZUL CLARO
      appBar: AppBar(
        title: Text("Dades de ${moto.marcaModelo}"), // Títol amb la marca i model de la moto
        backgroundColor: const Color.fromARGB(255, 185, 136, 194), // COLOR DE FONDO MORADO
        foregroundColor: Colors.white, // COLOR DEL TEXTO BLANCO
      ),
      body: Center(
        child: SingleChildScrollView( 
          padding: const EdgeInsets.symmetric(vertical: 24), // PADDING VERTICAL
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // CENTRADO VERTICAL
            children: [
              Text("Consum: ${moto.consumptionL100} L/100km", style: const TextStyle(fontSize: 18)), // Texto de consumo
              Text("Dipòsit: ${moto.fuelTankLiters} L", style: const TextStyle(fontSize: 18)), // Texto de capacidad del depósito
              Text("Autonomia estimada: ${moto.autonomiaKm.toStringAsFixed(1)} km",  
                  style: const TextStyle(fontSize: 18)), // Texto de autonomía estimada
              const SizedBox(height: 20), 
              SizedBox(
                width: 300, // Ancho fijo para los TextFields
                child: TextField(
                  controller: kmInicialController, // Controlador del TextField
                  keyboardType: const TextInputType.numberWithOptions(decimal: true), // Tipo de teclado numérico con decimal
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')), // Permite solo números y punto decimal
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      final text = newValue.text; // Obtiene el texto nuevo
                      if (text.indexOf('.') != text.lastIndexOf('.')) // Si hay más de un punto decimal
                        return oldValue;  // Retorna el valor antiguo
                      return newValue; // Retorna el nuevo valor
                    }),
                  ],
                  decoration: const InputDecoration( 
                    labelText: "Km quan vas omplir", // Etiqueta del TextField
                    border: OutlineInputBorder(), // Borde del TextField
                  ), ),),
              const SizedBox(height: 15), // Espacio entre los TextFields
              SizedBox(
                width: 300, // Ancho fijo para los TextFields
                child: TextField(
                  controller: kmActualController, // Controlador del TextField
                  keyboardType: 
                      const TextInputType.numberWithOptions(decimal: true), // Tipo de teclado numérico con decimal
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')), // Permite solo números y punto decimal
                    TextInputFormatter.withFunction((oldValue, newValue) { // Formateador personalizado
                      final text = newValue.text; // Obtiene el texto nuevo
                      if (text.indexOf('.') != text.lastIndexOf('.')) // Si hay más de un punto decimal
                        return oldValue; // Retorna el valor antiguo
                      return newValue; // Retorna el nuevo valor
                    }),],
                  decoration: const InputDecoration( // Decoración del TextField
                    labelText: "Km actuals", // Etiqueta del TextField
                    border: OutlineInputBorder(), // Borde del TextField
                  ),), ),
              const SizedBox(height: 12), // Espacio antes del mensaje de error
              if (errorText != null) // Si hay texto de error
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0), // Padding horizontal
                  child: Text( 
                    errorText!, 
                    style: const TextStyle(color: Colors.red, fontSize: 14), // Estilo del texto de error
                    textAlign: TextAlign.center, // Alineación centrada
                  ),),
              const SizedBox(height: 12), // Espacio antes del botón
              ElevatedButton(
                style: ElevatedButton.styleFrom( 
                  backgroundColor: const Color.fromARGB(255, 210, 138, 224), // Color de fondo del botón
                  foregroundColor: Colors.white, // Color del texto del botón
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 14), // Relleno del botón
                ),
                onPressed: calcular, // Llama a la función calcular al presionar el botón
                child: const Text("Calcular", style: TextStyle(fontSize: 16)), // Texto del botón
              ),
              const SizedBox(height: 20), // Espacio antes del resultado
              if (resultat != null) // Si hay resultado
                Text(
                  "Pots fer encara: ${resultat!.toStringAsFixed(1)} km",  // Texto del resultado
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),  // Estilo del texto del resultado
                  textAlign: TextAlign.center,  // Alineación centrada
                ), ],),),),);}}
