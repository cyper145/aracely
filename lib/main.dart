import 'package:flutter/material.dart';

import 'package:nusaramina/src/bloc/provider.dart';
import 'package:nusaramina/src/pages/dashboard_page.dart';

import 'package:nusaramina/src/pages/home_page.dart';
import 'package:nusaramina/src/pages/login_page.dart';

import 'package:nusaramina/src/pages/nus/nus_page.dart';
import 'package:nusaramina/src/pages/producto_page.dart';
import 'package:nusaramina/src/pages/registro_page.dart';
import 'package:nusaramina/src/pages/tabs/actos/acto_page.dart';
import 'package:nusaramina/src/preferencias_usuario/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'dashboard',
        routes: {
          'login': (BuildContext context) =>
              LoginPage(), // esta pendienta por razones ovias
          'dashboard': (BuildContext context) => DashboardPage(),
          'registro': (BuildContext context) => RegistroPage(),
          'home': (BuildContext context) => HomePage(),
          'producto': (BuildContext context) => ProductoPage(),
          'nus': (BuildContext context) => NusPage(),
          'acto': (BuildContext context) => ActoPage(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(89, 182, 171, 1.0),
        ),
      ),
    );
  }
}
