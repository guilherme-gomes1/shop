import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProdutctDetailPage extends StatelessWidget {
  const ProdutctDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
