import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto_final/models/poductos-models.dart';
import 'package:proyecto_final/pages/adicionar.dart';
import 'package:proyecto_final/pages/crear_productos.dart';
import 'package:proyecto_final/pages/lista.dart';
import 'package:proyecto_final/services/firebase_services.dart';
import 'package:proyecto_final/widgets/header.dart';

import 'detalleproducto.dart';
import 'lista_pedido.dart';
import 'otra_pagina.dart';

class Principal extends StatefulWidget {
  Principal({Key? key}) : super(key: key);

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
   List<ProductosModel> _productosModel = <ProductosModel>[];
   List<ProductosModel> _listaCarro = [];

   FirebaseService db = new FirebaseService();

       StreamSubscription<QuerySnapshot>? productSub;

   
   @override
  void initState() {
    super.initState();

    // ignore: deprecated_member_use
    _productosModel = [];
    
    productSub?.cancel();
    
    
    productSub = db.getProductList().listen((QuerySnapshot snapshot) {
      final List<ProductosModel> products = snapshot.docs
          .map((documentSnapshot) =>
              ProductosModel.fromMap(documentSnapshot.data() as Map<dynamic, dynamic> )) //38 
          .toList();

      setState(() {
        this._productosModel = products;
      });
    });
    
  }
 

  @override
  void dispose() {
    productSub?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('APP Repuestos dos'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    size: 38,
                  ),
                  if (_listaCarro.length > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          _listaCarro.length.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                      ),
                    ),
                ],
              ),
               onTap: () {
                  if (_listaCarro.isNotEmpty)
                    Navigator.of(context).push(
                      MaterialPageRoute(
                       builder: (context) => Cart(_listaCarro),
                     ),
                   );
               },
            ),
          )
        ],
      ),
      drawer: Container(
        width: 170.0,
        child: Drawer(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            color: Colors.black,
            child: new ListView(
              padding: EdgeInsets.only(top: 50.0),
              children: <Widget>[
                Expanded(
                  child: Flexible(
                    child: Container(
                      height: 140,
                      width: 120,
                      child: Flexible(
                        child: new UserAccountsDrawerHeader(
                          accountName: new Text(''),
                          accountEmail: new Text(''),
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/1.jpeg'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Crear repuestos',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: new Icon(
                    Icons.home,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>CrearProductos(),
                  )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Crear Cliente',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: new Icon(
                    Icons.card_giftcard,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => AgregarMensajero(),
                  )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Listado Cliente',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: new Icon(
                    Icons.card_giftcard,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>  ListaMensajeros(),
                  )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Repuestos',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: new Icon(
                    Icons.cable_sharp,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>CrearProductos(),
                  )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    '',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: new FaIcon(
                    FontAwesomeIcons.qrcode,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => otraPagina(),
                  )),
                ),
                new Divider(),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            child: Column(
              
              children: <Widget>[
                Stack(
                  children: <Widget>[
                     WaveClip(),
                    Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(left: 24, top: 48),
                      height: 150,
                      child: ListView.builder(
                        itemCount: _productosModel.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                            children: <Widget>[
                              Container(
                                height: 300,
                                padding: new EdgeInsets.only(
                                    left: 10.0, bottom: 10.0),
                                child: Card(
                                  elevation: 7.0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            '${_productosModel[index].imagen}' +
                                                '?alt=media',
                                        fit: BoxFit.cover,
                                        placeholder: (_, __) {
                                          return Center(
                                              child: CupertinoActivityIndicator(
                                            radius: 15,
                                          ));
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Container(height: 3.0, color: Colors.grey),
                SizedBox(
                  height: 5.0,
                ),
               Container(
                    color: Colors.grey[300],
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(4.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: _productosModel.length,
                      itemBuilder: (context, index) {
                        final String imagen = _productosModel[index].imagen;
                        var item = _productosModel[index];
                        return Card(
                            elevation: 4.0,
                            child: Stack(
                              fit: StackFit.loose,
                              alignment: Alignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              '${_productosModel[index].imagen}' +
                                                  '?alt=media',
                                          fit: BoxFit.cover,
                                          placeholder: (_, __) {
                                            return Center(
                                                child:
                                                    CupertinoActivityIndicator(
                                              radius: 15,
                                            ));
                                          }),
                                    ),
                                    Text(
                                      '${_productosModel[index].nombre}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Text(
                                          //'${_productosModel[index].preciocompra.toString()}',
                                          '${_productosModel[index].pricioVenta(_productosModel[index].preciocompra).toString()}'
                                          ,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23.0,
                                              color: Colors.black),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8.0,
                                            bottom: 8.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: GestureDetector(
                                              child:
                                                  (!_listaCarro.contains(item))
                                                      ? Icon(
                                                          Icons.shopping_cart,
                                                          color: Colors.green,
                                                          size: 38,
                                                        )
                                                      : Icon(
                                                          Icons.shopping_cart,
                                                          color: Colors.red,
                                                          size: 38,
                                                        ),
                                              onTap: () {
                                                setState(() {
                                                  if (!_listaCarro
                                                      .contains(item))
                                                    _listaCarro.add(item);
                                                  else
                                                    _listaCarro.remove(item);
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8.0,
                                            bottom: 8.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: GestureDetector(
                                              child:
                                                  
                                                      Icon(
                                                          Icons.description,
                                                          color: Colors.green,
                                                          size: 38,
                                                        ),
                                                       
                                                    
                                              onTap: () {
                                                setState(() {
                                                  
                                                 Navigator.of(context).push(new MaterialPageRoute(
                                                        builder: (BuildContext context) =>detalleproducto(item),
                                                         ));




                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ));
                      },
                    )
                    ),
              ],
            ),
          )),
        ));

              
            
              
              
              
              
  }
  
  // GridView _cuadroProductos() {
  //   return 
  // }
 


 
}