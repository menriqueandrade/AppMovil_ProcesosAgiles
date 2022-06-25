import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto_final/pages/lista_pedido.dart';
import 'package:proyecto_final/pages/login_page.dart';
import 'package:proyecto_final/pages/otra_pagina.dart';
import 'package:proyecto_final/pages/principal.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/poductos-models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'App Repuestos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  


 @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Parcial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        visualDensity: VisualDensity.adaptivePlatformDensity,
       
        primarySwatch: Colors.blue,
      ),

      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id : (context) => LoginPage(),
      },
     // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }




  
  
}


