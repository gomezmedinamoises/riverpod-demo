import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/models/product.dart';

/// Creamos un StateNotifierProvider llamado cartStateNotifierProvider con eliminación automática mediante el autoDispose
final cartStateNotifierProvider =
    StateNotifierProvider.autoDispose<CartStateNotifier, List<Product>>((ref) {
  return CartStateNotifier();
});

/// Se define la clase CartStateNotifier que extiende de StateNotifier
/// Esta clase maneja el estado de una lista de productos
class CartStateNotifier extends StateNotifier<List<Product>> {
  CartStateNotifier() : super([]);

  /// Se crea un método para agregar productos al carrito
  /// En este método, state se refiere al estado actual que está siendo administrado por el StateNotifier
  /// En este caso concreto, el estado es una lista de productos
  /// El spread operator (...) se usa para crear una nueva lista a partir del state y agregar el producto indicado
  void addProduct(Product product) {
    state = [...state, product];
  }

  /// Con este método, definimos que el estado actual del StateNotifier es una lista vacía
  void clearCart() {
    state = [];
  }
}
