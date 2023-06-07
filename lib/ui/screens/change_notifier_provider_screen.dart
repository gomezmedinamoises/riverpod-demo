import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/cart_notifier.dart';
import '../../models/product.dart';

/// Se extiende de la clase ConsumerWidget para consumir un Provider, en este caso, un ChangeNotifierProvider
class ChangeNotifierProviderScreen extends ConsumerWidget {
  const ChangeNotifierProviderScreen({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    /// Se crea una referencia al cartNotifierProvider para observar y obtener su estado actual
    final cartNotifier = ref.watch(cartNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: const Text('ChangeNotifier Provider'),
        actions: [
          Stack(children: [
            //Shopping cart icon with a badge
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                // Show a dialog with the cart contents
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Cart'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Show the cart contents
                          /// Usando el operador ... (spread operator), creamos una lista de widgets Text a partir de los elementos del carrito
                          /// Cada elemento es mapeado a un widget Text que muestra el título del producto
                          ...cartNotifier.cart.map((item) => Text(item.title)),
                          const SizedBox(height: 16),
                          // Sum the total price of the cart
                          /// Se usa el método fold para sumar el precio de cada elemento en el carrito, así obtenemos un total.
                          /// El resultado se muestra como un Text en foramto Total:$x.xx
                          Text(
                            'Total: \$${cartNotifier.cart.fold<double>(0, (sum, item) => sum + item.price)}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Clear the cart
                            /// El método read permite obtener una referencia al CartNotifier
                            /// Al presionar este TextButton, llamamos al método clearCart, el cual limpiará el carrito dejándolo sin productos
                            ref.read(cartNotifierProvider.notifier).clearCart();
                          },
                          child: const Text('Clear'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            //Badge
            Positioned(
              right: 0,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  /// Se obtiene la longitud del carrito desde el CartNotifier y se convierte en un string
                  cartNotifier.cart.length.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]),
        ],
      ),
      body: Column(
        children: [
          // A list of products and a button to add to cart
          Expanded(
            child: ListView.builder(
              /// Se crea una lista cuya longitud corresponderá al tamaño de la lista de productos dentro de productList
              itemCount: productList.length,
              itemBuilder: (context, index) {
                /// La variable product corresponderá a cada uno de los elementos correspondientes a cada índice del productList
                final product = productList[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text('\$${product.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      // Add the product to the cart
                      /// Usando el ref como referencia del CartNotifier, usamos los métodos read para obtener el estado del CartNotifier
                      /// y el método addProduct para agregar un producto
                      ref
                          .read(cartNotifierProvider.notifier)
                          .addProduct(product);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}