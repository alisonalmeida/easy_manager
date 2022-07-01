// ignore_for_file: prefer_const_constructors

import 'package:easy_manager/consts.dart';
import 'package:easy_manager/models/address_model.dart';
import 'package:easy_manager/models/client_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CrudClientScreen extends StatefulWidget {
  const CrudClientScreen({Key? key}) : super(key: key);

  @override
  State<CrudClientScreen> createState() => _CrudClientScreenState();
}

class _CrudClientScreenState extends State<CrudClientScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _cpf = TextEditingController();
  final TextEditingController _cep = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _observations = TextEditingController();
  late Box _clientBox;

  void openBox() async {
    _clientBox = await Hive.openBox<Client>(kClientBox);
  }

  @override
  void initState() {
    openBox();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Cliente'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: ListView(
            children: [
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                    hintText: 'Nome Completo'),
              ),
              TextFormField(
                controller: _cpf,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CPF',
                    hintText: 'CPF'),
              ),
              TextFormField(
                controller: _cep,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CEP',
                    hintText: 'CEP'),
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Telefone',
                    hintText: 'Telefone'),
              ),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'email',
                    hintText: 'email'),
              ),
              TextFormField(
                controller: _observations,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Observações',
                    hintText: 'Observações'),
              ),
              ElevatedButton(
                  onPressed: () async {
                    Address address = Address(
                        id: _cpf.text,
                        cep: '',
                        logradouro: 'logradouro',
                        complemento: 'complemento',
                        bairro: 'bairro',
                        localidade: 'localidade',
                        uf: 'uf',
                        numero: 'numero');
                    Client client = Client(
                        name: _name.text,
                        cpf: _cpf.text,
                        address: address,
                        phoneList: [],
                        email: _email.text,
                        observations: _observations.text);

                    _clientBox.add(client);

                    Navigator.pop(context);
                  },
                  child: Text('Salvar'))
            ],
          ),
        ),
      ),
    );
  }
}
