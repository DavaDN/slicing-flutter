import 'package:flutter/material.dart';
import 'cart.dart';  
import 'profile.dart';  

void main() => runApp(const Home());

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CartItem> _cartItems = [];
  int _currentIndex = 0;  // To track the current index for BottomNavigationBar

  void addToCart(CartItem item) {
    setState(() {
      _cartItems.add(item);
    });
  }

  // Method to handle navigation based on index
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Cart(cartItems: _cartItems),
        ),
      );
    }
    // Add additional navigation logic for other tabs if needed
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Pfl()), // Navigate to Profile page
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Bagian kategori
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryItem(isSelected: true, iconPath: 'assets/burger.jpg'),
                CategoryItem(isSelected: false, iconPath: 'assets/burger.jpg'),
                CategoryItem(isSelected: false, iconPath: 'assets/teh_botol.jpg'),
              ],
            ),
          ),
          // Judul dan list makanan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'All Food',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 2 / 2.5,
                    padding: const EdgeInsets.all(15.0),
                    children: [
                      FoodItem(
                        imagePath: 'assets/burger.jpg',
                        name: 'Burger King large',
                        price: 'Rp. 50.000,00',
                        onAdd: () => addToCart(
                          CartItem(
                            name: 'Burger King large',
                            price: 50000,
                            quantity: 1,
                            imagePath: 'assets/burger.jpg',
                          ),
                        ),
                      ),
                      FoodItem(
                        imagePath: 'assets/burger.jpg',
                        name: 'Burger King medium',
                        price: 'Rp. 35.000,00',
                        onAdd: () => addToCart(
                          CartItem(
                            name: 'Burger King medium',
                            price: 35000,
                            quantity: 1,
                            imagePath: 'assets/burger.jpg',
                          ),
                        ),
                      ),
                      FoodItem(
                        imagePath: 'assets/burger.jpg',
                        name: 'Burger King small',
                        price: 'Rp. 22.000,00',
                        onAdd: () => addToCart(
                          CartItem(
                            name: 'Burger King small',
                            price: 22000,
                            quantity: 1,
                            imagePath: 'assets/burger.jpg',
                          ),
                        ),
                      ),
                      FoodItem(
                        imagePath: 'assets/teh_botol.jpg',
                        name: 'Teh Botol',
                        price: 'Rp. 4.000,00',
                        onAdd: () => addToCart(
                          CartItem(
                            name: 'Teh Botol',
                            price: 4000,
                            quantity: 1,
                            imagePath: 'assets/teh_botol.jpg',
                          ),
                        ),
                      ),
                      FoodItem(
                        imagePath: 'assets/cocacola.jpg',
                        name: 'Coca Cola large',
                        price: 'Rp. 8.000,00',
                        onAdd: () => addToCart(
                          CartItem(
                            name: 'Coca Cola large',
                            price: 8000,
                            quantity: 1,
                            imagePath: 'assets/cocacola.jpg',
                          ),
                        ),
                      ),
                      FoodItem(
                        imagePath: 'assets/cocacola.jpg',
                        name: 'Coca Cola medium',
                        price: 'Rp. 6.000,00',
                        onAdd: () => addToCart(
                          CartItem(
                            name: 'Coca Cola medium',
                            price: 6000,
                            quantity: 1,
                            imagePath: 'assets/cocacola.jpg',
                          ),
                        ),
                      ),
                      FoodItem(
                        imagePath: 'assets/cocacola.jpg',
                        name: 'Coca Cola small',
                        price: 'Rp. 4.000,00',
                        onAdd: () => addToCart(
                          CartItem(
                            name: 'Coca Cola small',
                            price: 4000,
                            quantity: 1,
                            imagePath: 'assets/cocacola.jpg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Set the current index
        onTap: _onTabTapped, // Set the tap handler
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Orders',
          ),
        ],
      ),
    );
  }
}

class FoodItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;
  final VoidCallback onAdd;

  const FoodItem({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(price),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.green),
                onPressed: onAdd,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final bool isSelected;
  final String iconPath;

  const CategoryItem({super.key, required this.isSelected, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Image.asset(iconPath, width: 40, height: 40),
        ),
      ],
    );
  }
}
