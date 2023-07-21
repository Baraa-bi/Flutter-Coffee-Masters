import 'package:coffee_masters/manager/data_manager.dart';
import 'package:coffee_masters/pages/offers_page.dart';
import 'package:coffee_masters/pages/menu_page.dart';
import 'package:coffee_masters/pages/orders_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Coffee Masters",
      theme: ThemeData(primarySwatch: Colors.brown),
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset("images/logo.png"),
        ),
        body: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var currentIndex = 0;

  DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    Widget getCurrentWidget() {
      switch (currentIndex) {
        case 1:
          return const OffersPage();
        case 2:
          return OrdersPage(
            dataManager: dataManager,
          );
        default:
          return MenuPage(
            dataManager: dataManager,
          );
      }
    }

    return Scaffold(
      body: getCurrentWidget(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.brown.shade200,
        backgroundColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            label: "Menu",
            icon: Icon(Icons.coffee),
          ),
          BottomNavigationBarItem(
            label: "Offers",
            icon: Icon(Icons.local_offer),
          ),
          BottomNavigationBarItem(
            label: "Cart",
            icon: Icon(Icons.shopping_cart),
          )
        ],
      ),
    );
  }
}
