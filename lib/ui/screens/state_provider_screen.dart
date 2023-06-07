import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Se crea la variable valueStateProvider, a la cual se le asigna un StateProvider con un valor predeterminado
/// A diferencia del Provider, el StateProvider permite la modificación del valor a través de la propiedad notifier
final valueStateProvider = StateProvider<int>((ref) => 50);

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  /// Usamos el objeto WidgetRef para acceder y observar el StateProvider
  Widget build(BuildContext context, WidgetRef ref) {
    /// Se crea la variable value para leer y observar el valor actual de valueStateProvider, el cual es un StateProvider
    /// Dicho valor es el que se termina asignando a value
    final value = ref.watch(valueStateProvider);
    /// Se establecer un listener usando ref.listen, el cual se activa cuando el valor del StateProvider cambia
    /// Usa dos parámetros: el valueStateProvider y una función callback que recibe el valor anterior (prev) y el valor actual (curr) 
    /// del StateProvider. De esta forma, si el valor actual es 65, se muestra un SnackBar
    ref.listen<int>(valueStateProvider, (prev, curr) {
      if (curr == 65) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Value is 65'))
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: const Text('State Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              /// Se toma el valor de value, el cual está escuchando el valor actual del StateProvider, y lo muestra en el texto
              'The value is $value',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                /// A través del metodo ref.read, se lee el valor del StateProvider y usando la propiedad notifier, se modifica
                /// En este caso, la modificación consiste en aumentar su valor en 1, como un contador
                ref.read(valueStateProvider.notifier).state++;
              },
              child: const Text('Increment'),
            ),
            ElevatedButton(
              onPressed: () {
                /// El método ref.invalidate se encarga de invalidar el StateProvider, lo que en la práctica restaura el StateProvider al
                /// valor predeterminado
                ref.invalidate(valueStateProvider);
              },
              child: const Text('Invalidate'),
            ),
          ],
        ),
      ),
    );
  }
}
