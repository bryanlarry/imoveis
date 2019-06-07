import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NovoImovel extends StatelessWidget {

  final formKey = GlobalKey<FormState>();

  Record record = new Record();

  var _tipos = ['Casa, Apartamento'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class NovoImovel{

  final formKey = GlobalKey<FormState>();

  Record record = new Record();

  var _tipos = ['Casa, Apartamento'];

  mainBottomSheet(BuildContext context){

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){

          body: Card(
            child: Padding(
              padding: EdgeInsets.all(6.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Logradouro:'
                      ),
                      validator: (input) => input.isEmpty ? 'Campo Obrigatório' : null,
                      onSaved: (input) => record.logradouro = input,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Bairro:'
                      ),
                      validator: (input) => input.isEmpty ? 'Campo Obrigatório' : null,
                      onSaved: (input) => record.bairro = input,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Quartos:'
                      ),
                      keyboardType: TextInputType.numberWithOptions(),
                      validator: (input) => input = null ? 'Campo Obrigatório' : null,
                      onSaved: (input) => record.quartos = num.tryParse(input),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Banheiros:'
                      ),
                      keyboardType: TextInputType.numberWithOptions(),
                      validator: (input) => input = null ? 'Campo Obrigatório' : null,
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
                      validator: (input) => input = null ? 'Campo Obrigatório' : null,
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: _submit(context),
                            child: Text('Salvar'),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );}
    );
  }

  _submit(BuildContext context){
    if(formKey.currentState.validate()){

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
      });

      Navigator.pop(context);
    }
  }

  /*_createTile(BuildContext context, String name, IconData icon, Function action){
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: (){
        Navigator.pop(context);
        action();
      },
    );
  }

  _action1(){
    print('action 1');
  }

  _action2(){
    print('action 2');
  }*/

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

}