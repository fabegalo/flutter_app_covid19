import 'Class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Corona>> fetchCases(http.Client client) async {
  final response = await client.get('https://fabegalo.000webhostapp.com/Projects/API%20-%20COVID/');

  return parseCases(response.body);
}

List<Corona> parseCases(js) {
  final parsed = json.decode(js).cast<Map<String, dynamic>>();

  return parsed.map<Corona>((json) => Corona.fromJson(json)).toList();
}

class TelaCases extends StatelessWidget {

  TelaCases({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 Tracker'),
        actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.language),
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/TelaGlobal');
              },
            ),
        ]
      ),
      body: FutureBuilder<List<Corona>>(
        future: fetchCases(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? CasesList(corona: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class CasesListt extends StatelessWidget {
  final List<Corona> corona;

  CasesListt({Key key, this.corona}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
      itemCount: corona.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(corona[index].name),
            subtitle: Text('Infectados: ' + corona[index].total + '     -     '
            'Mortes: '+ corona[index].totaldead + '                                   '
            'Ultima Atualização:  ' + corona[index].update),
            onTap: (){Navigator.pushNamed(context, '/TelaAreas', arguments: Arg(
              country: corona[index].name, 
              update: corona[index].update,
              area: corona[index].areas ?? 'empty')
          );}
        );
      },
    );
  }
}


class CasesList extends StatefulWidget {
  final List<Corona> corona;
  CasesList({Key key, this.corona}) : super(key: key);

  @override
  _CasesListState createState() => _CasesListState(corona: corona);
}

class _CasesListState extends State<CasesList> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  List<Corona> corona;
  _CasesListState({Key key, this.corona});

  @override
  
  Widget build(BuildContext context) {

    return new Scaffold(
       body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          var client = http.Client();
          final response = await client.get('https://fabegalo.000webhostapp.com/Projects/API%20-%20COVID/');

          List<Corona> coronados = parseCases(response.body);
          setState(() {
            corona = coronados;
          });
        },
        child: buildGridView(corona),
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
    return ListView.builder(
      itemCount: corona.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(corona[index].name),
            subtitle: Text('Infectados: ' + corona[index].total + '     -     '
            'Mortes: '+ corona[index].totaldead + '                                   '
            'Ultima Atualização:  ' + corona[index].update),
            onTap: (){Navigator.pushNamed(context, '/TelaAreas', arguments: Arg(
              country: corona[index].name, 
              update: corona[index].update,
              area: corona[index].areas ?? 'empty')
          );}
        );
      },
    );
  }
}