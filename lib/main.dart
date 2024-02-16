import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

InAppLocalhostServer localhostServer = InAppLocalhostServer();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await localhostServer.start();
  runApp(const SpaceXplorerApp());
}

class SpaceXplorerApp extends StatelessWidget {
  const SpaceXplorerApp({super.key});
  static const appTitle = 'Space eXplorer';
  static const appColor = Color.fromRGBO(1, 11, 25, 1);
  static const url = 'http://localhost:8080/assets/index.html';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
          primarySwatch: MaterialColor(appColor.value, {
        50: Color.fromRGBO(appColor.red, appColor.green, appColor.blue, .1),
        100: Color.fromRGBO(appColor.red, appColor.green, appColor.blue, .2),
        200: Color.fromRGBO(appColor.red, appColor.green, appColor.blue, .3),
        300: Color.fromRGBO(appColor.red, appColor.green, appColor.blue, .4),
        400: Color.fromRGBO(appColor.red, appColor.green, appColor.blue, .5),
        500: Color.fromRGBO(appColor.red, appColor.green, appColor.blue, .6),
        600: Color.fromRGBO(appColor.red, appColor.green, appColor.blue, .7),
        700: Color.fromRGBO(appColor.red, appColor.green, appColor.blue, .8),
        800: Color.fromRGBO(appColor.red, appColor.green, appColor.blue, .9),
        900: Color.fromRGBO(appColor.red, appColor.green, appColor.blue, 1),
      })),
      home: const SpaceXplorerGame(),
    );
  }
}

class SpaceXplorerGame extends StatefulWidget {
  const SpaceXplorerGame({super.key});

  @override
  State<SpaceXplorerGame> createState() => _SpaceXplorerGameState();
}

class _SpaceXplorerGameState extends State<SpaceXplorerGame> {
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(SpaceXplorerApp.url)),
      onConsoleMessage: (controller, consoleMessage) =>
          log(consoleMessage.message),
    );
  }

  @override
  void dispose() {
    localhostServer.close();
    super.dispose();
  }
}
