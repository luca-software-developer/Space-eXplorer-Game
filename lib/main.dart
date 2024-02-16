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
  static const primaryColor = Color(0x010b19ff);
  static const url = 'http://localhost:8080/assets/index.html';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
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
