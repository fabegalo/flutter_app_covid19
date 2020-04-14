import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'Class.dart';

Future<List<Corona>> fetchGlobal(http.Client client) async {
  final response = await client.get('https://fabegalo.000webhostapp.com/Projects/API%20-%20COVID/?world=1');

  return parseGlobal(response.body);
}

List<Corona> parseGlobal(js) {
  final parsed = json.decode(js).cast<Map<String, dynamic>>();

  return parsed.map<Corona>((json) => Corona.fromJson(json)).toList();
}

class TelaGlobal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mundo'),
      ),
      body: FutureBuilder<List<Corona>>(
        future: fetchGlobal(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? GlobalList(corona: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class GlobalList extends StatefulWidget {
  final List<Corona> corona;
  GlobalList({Key key, this.corona}) : super(key: key);

  @override
  _GlobalListState createState() => _GlobalListState(corona: corona);
}

class _GlobalListState extends State<GlobalList> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  final List<Corona> corona;
  _GlobalListState({Key key, this.corona});

  @override
  
  Widget build(BuildContext context) {

    return new Scaffold(
       body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          var client = http.Client();
          final response = await client.get('https://fabegalo.000webhostapp.com/Projects/API%20-%20COVID/?world=1');

          List<Corona> coronados = parseGlobal(response.body);
          setState(() {
            corona[0] = coronados[0];
          });
        },
        child: buildGridView(corona[0]),
        // FlatButton(
        //   color: Colors.green,
        //   textColor: Colors.white,
        //   disabledColor: Colors.grey,
        //   disabledTextColor: Colors.black,
        //   padding: EdgeInsets.all(8.0),
        //   splashColor: Colors.blueAccent,
        //   onPressed: () {    
        //     _showDialog(context);
        // },
        // child: Text(
        //   "Salvar",
        // ),
        // )
        ),
    );
  }

  Widget buildGridView(arg) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 1,
      childAspectRatio: 1,
      children: List.generate(1, (index) {
        Area area = Area(name: arg.name,total: arg.total, totaldead: arg.totaldead, totallive: arg.totallive); //retorna os valores de cada pais
        int ativos = 0;
        int aux1;
        int aux2;
        aux1 = int.parse(area.totaldead);
        aux2 = int.parse(area.totallive);
        ativos = int.parse(area.total);
        ativos = ativos - (aux1 + aux2); //conta os casos ativos
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(child: Text(area.name , style: TextStyle(color: Colors.black, fontSize: 50, height: 1.5))),
                Text(''),
                Text(''),
                Text('Casos: ' + area.total.toString() , style: TextStyle(color: Colors.lightBlue, fontSize: 30)),
                Text('Casos Ativos: ' + ativos.toString(), style: TextStyle(color: Colors.orange, fontSize: 30)),
                Text('Mortes: ' + area.totaldead, style: TextStyle(color: Colors.red, fontSize: 30)),
                Text('Recuperados: ' + area.totallive, style: TextStyle(color: Colors.green, fontSize: 30)),
              ],
            ),
            Positioned(
              right: 1,
               child: InkWell(
                 child: Icon(
                   Icons.list,
                   size: 80,
                   color: Colors.blue,
                 ),
                 onTap: (){Navigator.pushNamed(context, '/TelaAreas', arguments: Arg(
                  country: corona[index].name, 
                  update: corona[index].update,
                  area: corona[index].areas ?? 'empty')
                  );
                }
               ),
             ),
            ],
          ),
        );
      }),
    );
  }

  void _showDialog(context) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Imagem Salva com sucesso!"),
          content: new Text("Sucesso!"),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}