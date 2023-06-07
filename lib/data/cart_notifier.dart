import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';

/// Se define un ChangeNotifierProvider llamado cartNotifierProvider, el cual se "autodispondrá" cuando no hayan consumidores activos
/// Crea una instancia de la clase CartNotifier
final cartNotifierProvider = ChangeNotifierProvider.autoDispose<CartNotifier>(
  (ref) => CartNotifier(),
);

/// Clase que extiende de ChangeNotifier, una clase proporcionada por flutter_riverpod para facilitar la notificación de los cambios de un 
/// ChangeNotifierProvider a los consumidores que lo estén observando
class CartNotifier extends ChangeNotifier {

  /// Se crea una lista vacía de productos
  final List<Product> _cart = [];

  /// Se crea un getter para acceder a la lista de productos del carrito
  List<Product> get cart => _cart;

  /// Se crean métodos para agregar o remover productos del carrito, incluso para limpiar el carrito completamente
  /// Cada uno de estos métodos notifica a los consumidores del cambio efectuado mediante el método notifyListeners
  void addProduct(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
