import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routs.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.purple,
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRouts.productForm, arguments: product);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text(
                      'Confirmar exclusão',
                    ),
                    content: const Text(
                        'Tem certeza que deseja excluir esse produto?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Sim'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Não'),
                      ),
                    ],
                  ),
                ).then((value) async {
                  if (value ?? true) {
                    try {
                      await Provider.of<ProductList>(
                        context,
                        listen: false,
                      ).removeProduct(product);
                    } on HttpException catch (error) {
                      msg.showSnackBar(SnackBar(
                        content: Text(
                          error.toString(),
                        ),
                      ));
                    }
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
