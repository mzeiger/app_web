import 'package:app_web/views/side_bar_screens.dart/buyers_screen.dart';
import 'package:app_web/views/side_bar_screens.dart/categories_screen.dart';
import 'package:app_web/views/side_bar_screens.dart/orders_screen.dart';
import 'package:app_web/views/side_bar_screens.dart/products_screen.dart';
import 'package:app_web/views/side_bar_screens.dart/upload_banners_screen.dart';
import 'package:app_web/views/side_bar_screens.dart/vendor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = const UploadBannersScreen();

  void screenSelector(item) {
    switch (item.route) {
      case BuyersScreen.id:
        setState(() {
          _selectedScreen = const BuyersScreen();
        });
        break;

      case VendorsScreen.id:
        setState(() {
          _selectedScreen = const VendorsScreen();
        });
        break;

      case CategoriesScreen.id:
        setState(() {
          _selectedScreen = const CategoriesScreen();
        });
        break;

      case OrdersScreen.id:
        setState(() {
          _selectedScreen = const OrdersScreen();
        });
        break;

      case ProductsScreen.id:
        setState(() {
          _selectedScreen = const ProductsScreen();
        });
        break;

      case UploadBannersScreen.id:
        setState(() {
          _selectedScreen = const UploadBannersScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar:
          AppBar(backgroundColor: Colors.blue, title: const Text('Management')),
      body: _selectedScreen,
      sideBar: SideBar(
        header: Container(
          height: 50,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.black),
          child: const Center(
            child: Text(
              'Multi Vendor Admin',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        items: const [
          AdminMenuItem(
              title: 'Vendors',
              route: VendorsScreen.id,
              icon: CupertinoIcons.person_3),
          AdminMenuItem(
              title: 'Buyers',
              route: BuyersScreen.id,
              icon: CupertinoIcons.person),
          AdminMenuItem(
              title: 'Orders',
              route: OrdersScreen.id,
              icon: CupertinoIcons.shopping_cart),
          AdminMenuItem(
              title: 'Categories',
              route: CategoriesScreen.id,
              icon: Icons.category),
          AdminMenuItem(
              title: 'Upload Banners',
              route: UploadBannersScreen.id,
              icon: Icons.upload),
          AdminMenuItem(
            title: 'Products',
            route: ProductsScreen.id,
            icon: Icons.store,
          ),
        ],
        selectedRoute: "bannersScreen.id",
        onSelected: (item) {
          screenSelector(item);
        },
      ),
    );
  }
}
