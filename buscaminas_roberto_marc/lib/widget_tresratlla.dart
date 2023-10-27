import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_data.dart';
import 'widget_tresratlla_painter.dart';

class WidgetTresRatlla extends StatefulWidget {
  const WidgetTresRatlla({Key? key}) : super(key: key);

  @override
  WidgetTresRatllaState createState() => WidgetTresRatllaState();
}

class WidgetTresRatllaState extends State<WidgetTresRatlla> {
  Future<void>? _loadImagesFuture;

  double medidadecuadrado = 30;
  double cuadradosancho = 15;
  double cuadradosalto = 15;

  // Al iniciar el widget, carrega les imatges
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppData appData = Provider.of<AppData>(context, listen: false);
      _loadImagesFuture = appData.loadImages(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: (Center(
            child: Container(
          width: medidadecuadrado * cuadradosancho,
          height: medidadecuadrado * cuadradosalto,
          color: Colors.blue,
          child: MyGridlist(),
        ))),
      ),
    );
  }
}

class MyGridlist extends StatelessWidget {
  int tamanyo = 1;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2, // Número de columnas en el grid
        children:  List.generate(tamanyo, (index) {
          return Container(
            margin: EdgeInsets.all(2),
            color: Colors.green,
            child: MyGrid(),
          );
        }));
  }
}

class MyGrid extends StatelessWidget {
  int tamanyo = 15;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: tamanyo, // Número de columnas en el grid
      children: List.generate(, (index) {
        return Container(
          margin: EdgeInsets.all(2),
          color: Colors.red,
          height: 100.0,
          child: Center(
            child:
                Text('Elemento $index', style: TextStyle(color: Colors.white)),
          ),
        );
      }),
    );
  }
}
