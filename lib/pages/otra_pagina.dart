import 'package:flutter/material.dart';
import 'package:proyecto_final/models/poductos-models.dart';

class otraPagina extends StatefulWidget {
  //ProductosModel cart ;

   //otraPagina(this.cart);



  @override
  _otraPaginaState createState() => _otraPaginaState();
}

class _otraPaginaState extends State<otraPagina> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Text('Otra Pagina', style: TextStyle(fontSize: 15.0),) ,
        ),
    );
  }
}