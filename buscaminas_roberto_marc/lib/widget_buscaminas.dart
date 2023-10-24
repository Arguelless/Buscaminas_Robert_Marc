import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'app_data.dart';
import 'widget_tresratlla_painter.dart';

class WidgetBuscaminas extends StatefulWidget {
  const WidgetBuscaminas({Key? key}) : super(key: key);

  @override
  WidgetBuscaminasState createState() => WidgetBuscaminasState();
}

class WidgetBuscaminasState extends State<WidgetBuscaminas> {
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);

    return GestureDetector(onTapUp: (TapUpDetails details) {});
  }
}
