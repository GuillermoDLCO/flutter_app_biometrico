import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final LocalAuthentication auth = LocalAuthentication();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
     _biometrico(); 
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _biometrico() async {
    bool flag=true;
    if(flag){
      bool authenticated=false;

      const androidString = const AndroidAuthMessages(
        cancelButton: "Cancelar",
        goToSettingsButton: "Ajustes",
        signInTitle: "Autentíquese",
        fingerprintHint: "Toque el Sensor",
        fingerprintNotRecognized: "Huella no reconocida",
        fingerprintSuccess: "Huella reconocida",
        goToSettingsDescription: "Por favor configure su huella",
      );

      List<BiometricType> biometricoDisponible;
      biometricoDisponible = await auth.getAvailableBiometrics();

      if(biometricoDisponible!=null){
        print(biometricoDisponible.toString());
        try {
        authenticated=await auth.authenticateWithBiometrics(
            localizedReason: "Autentíquese para acceder",
            useErrorDialogs: true,
            stickyAuth: true,
            androidAuthStrings: androidString,
          );
          if (!authenticated) {
            exit(0);
          }
        } catch (e) {
          print(e);
        }

        if (!mounted) {
          return;
        }
      }

      
    }
  }
}
