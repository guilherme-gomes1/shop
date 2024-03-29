import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/pages/produtct_detail_page.dart';
import 'package:shop/utils/app_routs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Lato',
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouts.home,
        routes: {
          AppRouts.home:(context) => const ProductsOverviewPage(),
          AppRouts.productDetail:(context) => const ProdutctDetailPage(),
          AppRouts.cart:(context) => const CartPage(),
          AppRouts.orders:(context) => const OrdersPage(),
          AppRouts.products:(context) => const ProductsPage(),
          AppRouts.productForm:(context) => const ProductFormPage(),
        },
      ),
    );
  }
}