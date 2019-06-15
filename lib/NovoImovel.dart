import 'dart:core';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NovoImovel extends StatelessWidget {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Record record = new Record();

  var _tipos = ['Casa', 'Apartamento'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Imóvel"),
      ),
        body: Center(
            child: Form(
              key: formKey,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(15.0),
                children: <Widget>[
                  Center(

                child: Card(
                  elevation: 8.0,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                        children: <Widget>[

                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Logradouro:'
                    ),

                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Campo Obrigatório';
                      }
                      return null;
                    },
                    onSaved: (input) => record.logradouro = input,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Bairro:'
                    ),
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Campo Obrigatório';
                      }
                      return null;
                    },
                    onSaved: (input) => record.bairro = input,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Quartos:'
                    ),
                    keyboardType: TextInputType.numberWithOptions(),
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Campo Obrigatório';
                      }
                      return null;
                    },
                    onSaved: (input) => record.quartos = num.tryParse(input),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Banheiros:'
                    ),
                    keyboardType: TextInputType.numberWithOptions(),
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Campo Obrigatório';
                      }
                      return null;
                    },
                    onSaved: (input) => record.banheiros = num.tryParse(input),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Área (m²):'
                    ),
                    keyboardType: TextInputType.numberWithOptions(),
                    onSaved: (input) => record.area = num.tryParse(input),
                  ),

                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Garagens:'
                    ),
                    keyboardType: TextInputType.numberWithOptions(),
                    onSaved: (input) => record.garagem = num.tryParse(input),
                  ),

                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Valor:'
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Campo Obrigatório';
                      }
                      return null;
                    },
                    onSaved: (input) => record.valor = num.tryParse(input),
                  ),

                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'IPTU:'
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onSaved: (input) => record.iptu = num.tryParse(input),
                  ),


                  DropdownButton<String>(
                    items: _tipos.map((String dropDownStringItem){
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String selecao) {
                      this.record.tipo = selecao;
                    },
                  ),

                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Descrição:'
                    ),
                    keyboardType: TextInputType.multiline,
                    onSaved: (input) => record.texto = input,
                  ),







                          new AssetBundleImageProvider
                          int i=0;
                          for(i = 0; i < record.fotos.size; i++){

                             Column(
                              children: <Widget>[
                                new Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                    Image.network(
                                        choice.imglink
                                    )),
                                new Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                    ],
                                  ),

                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )
                          }






                        ])
                  ))
                  ),

                  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: RaisedButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          _submit(context);
                        }
                      },
                      child: Text('Salvar'),
                    ),
                ),
                ],
              ),
            ),
          ),
    );
  }

  _submit(BuildContext context){

      Firestore.instance
          .collection('imovel')
          .add({
        "logradouro": record.logradouro,
        "bairro": record.bairro,
        "quartos": record.quartos,
        "banheiros": record.banheiros,
        "area": record.area,
        "garagem": record.garagem,
        "tipo": record.tipo,
        "valor": record.valor,
        "iptu": record.iptu,
        "texto": record.texto,
        "fotos": record.fotos,
      });

      Navigator.pop(context);

  }
}

class Record {

  String logradouro;
  String bairro;
  int quartos;
  int banheiros;
  int area;
  int garagem;
  String tipo;
  int valor;
  int iptu;
  String texto;
  List<String> fotos;

}