import 'package:flutter/material.dart';
import 'package:shop/utils/app_routs.dart';

class AppDrawer extends StatelessWidget {

  const AppDrawer({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Drawer(
        child: Column(
          children: [
            AppBar(
              title: const Text('Bem-vindo Usuário'),
              automaticallyImplyLeading: false,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shop, color: Colors.black,),
              title: const Text('Loja'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRouts.home);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment, color: Colors.black,),
              title: const Text('Pedidos'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRouts.orders);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.black,),
              title: const Text('Gerenciar Produtos'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRouts.products);
              },
            ),
          ],
        ),
       );
  }
}