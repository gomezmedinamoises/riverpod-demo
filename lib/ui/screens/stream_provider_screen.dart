import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/services/stream_service.dart';

/// Se define un StreamProvider llamado streamValueProvider, el cual representa un Stream de integers.
/// El StreamProvider se "autodispondrá" una vez no existan más consumidores activos.
final streamValueProvider = StreamProvider.autoDispose((ref) {
  final streamService = ref.watch(streamServiceProvider);
  return streamService.getStream();
});

/// Se extiende de ConsumerWidget para poder consumir el streamValueProvider y escuchar los valores que emita
class StreamProviderScreen extends ConsumerWidget {
  const StreamProviderScreen({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    /// Se crea una referencia al streamValueProvider para observar y obtener su estado actual
    final streamValue = ref.watch(streamValueProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: const Text('Stream Provider'),
      ),
      body: Center(
        /// Usamos el when para definir la UI dependiendo del estado: data define el estado exitoso
        /// En otras palabras, el when permite manejar los diferentes estados de un Stream
        /// En este caso, cuando streamValue tenga datos, se mostrarán en un texto en pantalla
        /// Cuando exista algún error, mostrará el mensaje de error en pantalla
        /// Cuando se estén cargando los datos, se mostrará un indicador de progreso
        child: streamValue.when(
          data: (int data) {
            return Text(data.toString(), style: const TextStyle(fontSize: 35),);
          },
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          loading: () {
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
