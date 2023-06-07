import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/services/api_service.dart';

import '../../models/suggestion.dart';

/// Se crea una variable llamada suggestionFutureProvider, la cual usa un FutureProvider
/// Este FutureProvider representa un valor futuro (Future) que devuelve una instancia de la clase Suggestion
/// Se usa el autoDispose para liberar los recursos asociados al FutureProvider cuando no exista un consumidor activo.
/// Para explicarlo mejor, recordar que el FutureProvider mantiene una referencia a su estado y a los consumidores que lo utilizan
/// Cuando ningún widget está observando o usando el valor del FutureProvider, se puede liberar y eliminar la referencia para
/// ahorrar recursos.
/// En Riverpod Flutter, hablamos de "autodisposición" a la capacidad de un Provider de liberar automáticamente sus recursos cuando no existen
/// consumidores activos. Esto es especialmente útil en operaciones asíncronas, ya que, en este caso del FutureProvider, permite que el Future
/// se cancele automáticamente cuando ya no es necesario, evitando memory leaks. A su vez, ayuda a optimizar el rendimiento del dispositivo y
/// evita la necesidad de gestionar manualmente la cancelación del Future cuando no sea necesario.
final suggestionFutureProvider =
    FutureProvider.autoDispose<Suggestion>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getSuggestion();
});

/// Usamos un clase que extiende de ConsumerWidget para que pueda consumir el proveedor que definimos en suggestionFutureProvider
class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Se crea una referencia al suggestionFutureProvider para observar y obtener su estado actual
    final suggestionRef = ref.watch(suggestionFutureProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: const Text('Future Provider'),
      ),

      /// El RefreshIndicator permite refrescar la pantalla al hacer swipe down
      body: RefreshIndicator(
        /// Se usa ref.refresh para actualizar el suggestionFutureProvider.future
        onRefresh: () => ref.refresh(suggestionFutureProvider.future),
        child: ListView(
          children: [
            /// Dependiendo del estado, se dibuja una UI diferente
            suggestionRef.when(
              data: (data) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                        data.type,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        data.activity,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                );
              },
              error: (error, _) {
                return Text(error.toString());
              },
              loading: () {
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
