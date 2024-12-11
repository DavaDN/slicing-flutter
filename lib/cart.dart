import 'package:flutter/material.dart';
import 'home.dart';

class Cart extends StatefulWidget {
  final List<CartItem> cartItems;

  const Cart({super.key, required this.cartItems});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  void _incrementQuantity(int index) {
    setState(() {
      widget.cartItems[index].quantity++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (widget.cartItems[index].quantity > 1) {
        widget.cartItems[index].quantity--;
      }
    });
  }

  void _deleteItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
  }

  int get total {
    int subtotal = widget.cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
    int tax = (subtotal * 0.11).round(); // Calculate 11% PPN
    return subtotal + tax;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return _buildCartItem(
                  item.name,
                  item.price,
                  item.quantity,
                  item.imagePath,
                  () => _incrementQuantity(index),
                  () => _decrementQuantity(index),
                  () => _deleteItem(index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryRow('PPN 11%', 'Rp ${(total - (total / 1.11).round()).toStringAsFixed(2)}'),
                _buildSummaryRow('Total Belanja', 'Rp ${(total / 1.11).round().toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                _buildSummaryRow('Total Pembayaran', 'Rp $total'),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    },
                    child: const Text('Checkout'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(String title, int price, int quantity, String imagePath, VoidCallback onIncrement, VoidCallback onDecrement, VoidCallback onDelete) {
    return ListTile(
      leading: Image.asset(imagePath),
      title: Text(title),
      subtitle: Text('Rp ${price * quantity}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: onDecrement,
          ),
          Text(quantity.toString()), // Display quantity
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: onIncrement,
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value),
      ],
    );
  }
}

class CartItem {
  final String name;
  final int price;
  final String imagePath;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imagePath,
  });
}
