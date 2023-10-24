import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'app_data.dart';

class LayoutSettings extends StatefulWidget {
  const LayoutSettings({Key? key}) : super(key: key);

  @override
  LayoutSettingsState createState() => LayoutSettingsState();
}

class LayoutSettingsState extends State<LayoutSettings> {
  List<String> midaTaulell = ["Petit", "Gran"];
  List<String> numeroMines = ["5", "10", "20"];

  // Mostra el CupertinoPicker en un diàleg.
  void _showPicker(String type) {
    List<String> options = type == "setting" ? midaTaulell : numeroMines;
    String title = type == "player"
        ? "Selecciona la mida del taulell"
        : "Selecciona el número de mines";

    // Troba l'índex de la opció actual a la llista d'opcions
    AppData appData = Provider.of<AppData>(context, listen: false);
    String currentValue =
        type == "setting" ? appData.midaTaulell : appData.numeroMines;
    int currentIndex = options.indexOf(currentValue);
    FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: currentIndex);

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            Container(
              color: CupertinoColors.secondarySystemBackground
                  .resolveFrom(context),
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SafeArea(
                top: false,
                child: CupertinoPicker(
                  itemExtent: 32.0,
                  scrollController: scrollController,
                  onSelectedItemChanged: (index) {
                    if (type == "setting") {
                      appData.midaTaulell = options[index];
                    } else {
                      appData.numeroMines = options[index];
                    }
                    // Actualitzar el widget
                    setState(() {});
                  },
                  children: options
                      .map((color) => Center(child: Text(color)))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Configuració"),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Mida del taulell: "),
              CupertinoButton(
                onPressed: () => _showPicker("setting"),
                child: Text(appData.midaTaulell),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Numero de mines: "),
              CupertinoButton(
                onPressed: () => _showPicker("opponent"),
                child: Text(appData.numeroMines),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
