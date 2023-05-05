import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, idx) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CartItemWidget(
                  items[idx],
                ),
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    backgroundColor: Colors.purple,
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  CartButton(cart: cart)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartButton extends StatefulWidget {
  const CartButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return _isLoading
        ? const CircularProgressIndicator()
        : TextButton(
            style: TextButton.styleFrom(
                textStyle: const TextStyle(
              color: Colors.purple,
            )),
            onPressed: widget.cart.itemsCount == 0
                ? null
                : () async {
                    try {
                      setState(() => _isLoading = true);
                      await Provider.of<OrderList>(
                        context,
                        listen: false,
                      ).addOrder(widget.cart);

                      widget.cart.clear();
                      msg.showSnackBar(const SnackBar(
                        content: Text(
                          'Compra efetuada com sucesso!',
                        ),
                        backgroundColor: Colors.green,
                      ));
                      setState(() => _isLoading = false);
                      Navigator.of(context).pop();
                    } catch (error) {
                      msg.showSnackBar(const SnackBar(
                        content: Text(
                          'Não foi possível concluir a compra!',
                        ),
                        backgroundColor: Colors.red,
                      ));
                      setState(() => _isLoading = false);
                    }
                  },
            child: const Text('COMPRAR'),
          );
  }
}
