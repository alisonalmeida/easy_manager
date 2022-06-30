import 'package:easy_manager/screens/crud_product_screen.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
      ),
      body: Center(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CrudProductScreen())),
              child: Card(
                child: ListTile(
                  title: Text('Cadastrar produto'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
