import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Se define un Provider llamado streamServiceProvider, el cual crea una instancia de la clase StreamService
final streamServiceProvider = Provider<StreamService>((ref) {
  return StreamService();
});

/// Se crea la clase StreamService que representa un Stream de integers
class StreamService {

  /// Método que retorna un Stream de integers
  Stream<int> getStream() {

    /// Usamos el método periodic para generar valores de forma periódica durante la cantidad de tiempo indicada.
    /// En este caso, creamos un entero cada segundo hasta tener un total de 10  valores.
    /// Estos valores son el índice i que aumenta en cada emisión de datos
    return Stream.periodic(const Duration(seconds: 1), (i) => i).take(10);
  }
}
