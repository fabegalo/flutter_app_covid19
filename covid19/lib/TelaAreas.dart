import 'package:flutter/material.dart';
import 'Class.dart';

class TelaAreas extends StatefulWidget {

  @override
  _TelaAreasState createState() => _TelaAreasState();
}

class _TelaAreasState extends State<TelaAreas> {

  @override
  
  Widget build(BuildContext context) {
    
    Arg arg = ModalRoute.of(context).settings.arguments;
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text(arg.country),
        ),
        body: Column(
          children: <Widget>[
        Expanded(
          child: buildGridView(arg),
          
        ),
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
          ],
        ),
    );
  }

  Widget buildGridView(arg) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1,
      children: List.generate(arg.area.length, (index) {
        Area area = arg.area[index]; //arg no indice x no argument
        int ativos = 0;
        int aux1;
        int aux2;
        aux1 = int.parse(area.totaldead);
        aux2 = int.parse(area.totallive);
        ativos = int.parse(area.total);
        ativos = ativos - (aux1 + aux2);
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Area: ' + area.name , style: TextStyle(color: Colors.black, fontSize: 20)),
                Text(''),
                Text('Casos: ' + area.total.toString() , style: TextStyle(color: Colors.lightBlue, fontSize: 18)),
                Text('Casos Ativos: ' + ativos.toString(), style: TextStyle(color: Colors.orange, fontSize: 18)),
                Text('Mortes: ' + area.totaldead, style: TextStyle(color: Colors.red, fontSize: 18)),
                Text('Recuperados: ' + area.totallive, style: TextStyle(color: Colors.green, fontSize: 18)),
              ],
            ),
            // Positioned(
            //   right: 5,
            //   top: 5,
            //   child: InkWell(
            //     child: Icon(
            //       Icons.remove_circle,
            //       size: 20,
            //       color: Colors.red,
            //     ),
            //     onTap: () {
            //       setState(() {
            //         Img img = images[index];
            //         img.imageFile = null;
            //         images.replaceRange(index, index + 1, [img]);
            //       });
            //     },
            //   ),
            // ),
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