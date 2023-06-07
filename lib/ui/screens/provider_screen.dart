import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Declaración del provider
/// Se crea la variable valueProvider que proporciona un entero constante cuyo valor es 42
/// El Provider utilizado es de solo lectura, por lo que solo podremos acceder al valor, pero no modificarlo directamente.
final valueProvider = Provider<int>((ref) => 42);

/// La clase ProviderScreen extiende de ConsumerWidget, que a su vez extiende de StatefulWidget.
/// Consumer Widget es una clase provista por el paquete flutter_riverpod, y se encarga de consumir y observar los cambios en un Provider.
/// Este puede considerarse un ejemplo del patrón Observer
class ProviderScreen extends ConsumerWidget {
  const ProviderScreen({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  /// El método build se encarga de construir la UI del widget. Recibe un contexto y un objeto Widget ref necesario para acceder a los Provider
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          title: const Text('Provider'),
        ),
        body: Center(
          child: Text(
            /// Se usa el método ref.watch() para leer y observar el valor del valueProvider y, en este caso, mostrarlo en el texto
            'The value is ${ref.watch(valueProvider)}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ));
  }
}
