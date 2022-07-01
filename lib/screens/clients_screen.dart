import 'package:easy_manager/screens/crud_client_screen.dart';
import 'package:easy_manager/screens/crud_product_screen.dart';
import 'package:flutter/material.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
      ),
      body: Center(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CrudClientScreen())),
              child: Card(
                child: ListTile(
                  title: Text('Cadastrar cliente'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
