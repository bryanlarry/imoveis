import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:imoveis/NovoImovel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Imóveis',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {

  NovoImovel novoImovel = new NovoImovel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Imóveis')),
      body: _buildBody(context),
      floatingActionButton: new FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => novoImovel.build(context)),
            );
          },
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('imovel').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.logradouro),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.logradouro),
          trailing: Text(record.bairro),
            onTap: () => print(record),
            onLongPress: () => _dialogExclusaoImovel(context, record.reference),
        ),
      ),
    );
  }
}

void _dialogExclusaoImovel(context, referencia){

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alerta"),
          content: new Text("Deseja deletar o registro?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Confirmar"),
              onPressed: () => deleteData(context, referencia),
            ),
            new FlatButton(
              child: new Text("Cancelar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      }
  );
}

deleteData(context, referencia) {
  Firestore.instance
      .collection('imovel')
      .document(referencia)
      .delete()
      .catchError((e) {
    print(e);
  });

  Navigator.of(context).pop();
}

class Record {
  final String logradouro;
  final String bairro;
  final int quartos;
  final int banheiros;
  final int area;
  final int garagem;
  final String tipo;
  final int valor;
  final int iptu;
  final String texto;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
     : /* assert(map['logradouro'] != null),
        assert(map['bairro'] != null),
        assert(map['quartos'] != null),
        assert(map['banheiros'] != null),
        assert(map['area'] != null),
        assert(map['garagem'] != null),
        assert(map['tipo'] != null),
        assert(map['valor'] != null),
        assert(map['iptu'] != null),*/
        logradouro = map['logradouro'],
        bairro = map['bairro'],
        quartos = map['quartos'],
        banheiros = map['banheiros'],
        area = map['area'],
        garagem = map['garagem'],
        tipo = map['tipo'],
        valor = map['valor'],
        iptu = map['iptu'],
        texto = map['texto'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$logradouro:$bairro>";
}