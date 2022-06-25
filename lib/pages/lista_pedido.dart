// import 'package:compras/models/productos_model.dart';
// import 'package:fancy_dialog/FancyAnimation.dart';
// import 'package:fancy_dialog/FancyGif.dart';
// import 'package:fancy_dialog/FancyTheme.dart';
// import 'package:fancy_dialog/fancy_dialog.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/models/poductos-models.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class Cart extends StatefulWidget {
  final List<ProductosModel> _cart;

  Cart(this._cart);

  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  _CartState(this._cart);

  final _scrollController = ScrollController();
  var _firstScroll = true;
  bool _enabled = false;

  List<ProductosModel> _cart;

  Container pagoTotal(List<ProductosModel> _cart) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(left: 120),
      height: 70,
      width: 400,
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          // Text("Total:  \$${valorTotal(_cart)}",
          //Text("Total:  ",
          Text("Total:  \$${valorTotal(_cart)}",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.black))
        ],
      ),
    );
  }

  String valorTotal(List<ProductosModel> listaProductos) {
    double total = 0.0;

    for (int i = 0; i < listaProductos.length; i++) {
      total = total +
          listaProductos[i].pricioVenta(listaProductos[i].preciocompra) *
              listaProductos[i].cantidad;
      // total = total +listaProductos[i].preciocompra * listaProductos[i].cantidad;
    }

    if (total < 0) {
      total = 0;
    }
    return total.toStringAsFixed(2);
  }

  String precioUnitario(ProductosModel item) {
    double total = 0.0;
    total += item.preciocompra * item.cantidad;

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.construction),
            onPressed: null,
            color: Colors.white,
          )
        ],
        title: Text('Detalle',
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _cart.length;
            });
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (_enabled && _firstScroll) {
              _scrollController
                  .jumpTo(_scrollController.position.pixels - details.delta.dy);
            }
          },
          onVerticalDragEnd: (_) {
            if (_enabled) _firstScroll = false;
          },
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              _cliente(),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _cart.length,
                itemBuilder: (context, index) {
                  // final String imagen = _cart[index].imagen;
                  var item = _cart[index];
                  //item.quantity = 0;
                  return Column(children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2.0),
                              child: Column(children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                      width: 150,
                                      height: 150,
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              '${item.imagen}' + '?alt=media',
                                          fit: BoxFit.cover,
                                          placeholder: (_, __) {
                                            return Center(
                                                child:
                                                    CupertinoActivityIndicator(
                                              radius: 15,
                                            ));
                                          }),
                                    )),
                                    Column(
                                      children: <Widget>[
                                        Text(item.nombre.trim(),
                                            style: new TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                                color: Colors.black)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 120,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.red[600],
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 6.0,
                                                      color: Colors.blue,
                                                      offset: Offset(0.0, 1.0),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(50.0),
                                                  )),
                                              margin:
                                                  EdgeInsets.only(top: 20.0),
                                              padding: EdgeInsets.all(2.0),
                                              child: new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  Flexible(
                                                    child: IconButton(
                                                      icon: Icon(Icons.remove),
                                                      onPressed: () {
                                                        _removeProduct(index);
                                                        valorTotal(_cart);
                                                        // print(_cart);
                                                      },
                                                      color: Colors.yellow,
                                                    ),
                                                  ),
                                                  Text(
                                                      '${_cart[index].cantidad}',
                                                      style: new TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 22.0,
                                                          color: Colors.white)),
                                                  IconButton(
                                                    icon: Icon(Icons.add),
                                                    onPressed: () {
                                                      _addProduct(index);
                                                      valorTotal(_cart);
                                                    },
                                                    color: Colors
                                                        .yellow, // print(_cart);
                                                  ),
                                                  SizedBox(
                                                    height: 8.0,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      child: SizedBox(
                                        width: 38.0,
                                      ),
                                    ),
                                    Text(
                                        item
                                            .pricioVenta(item.preciocompra)
                                            .toString(),
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24.0,
                                            color: Colors.black))
                                  ],
                                ),
                                Divider(
                                  color: Colors.purple,
                                )
                              ]),
                            )
                          ],
                        )),
                  ]);
                },
              ),
              SizedBox(
                width: 10.0,
              ),
              pagoTotal(_cart),
              SizedBox(
                width: 20.0,
              ),
              Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.only(top: 50),
                // ignore: deprecated_member_use
              ),
              SizedBox(
                width: 40.0,
              ),
              _bottonLogin2(),
              SizedBox(
                width: 20.0,
              ),
            ],
          ))),
    );
  }

  _addProduct(int index) {
    setState(() {
      if (_cart[index].cantidad >= 0) {
        _cart[index].cantidad++;
      }
    });
  }

  _removeProduct(int index) {
    setState(() {
      if (_cart[index].cantidad >= 1) {
        _cart[index].cantidad--;
      }
    });
  }

  Widget _cliente() {
    var _lista = ['carro', 'cada', 'vaca'];
    String vista = 'seleccione un cliente';

    return Container(
        height: 100,
        width: 100,
        child: Scaffold(
          body: Center(
              // child: DropdownButton(
              //   items: [],
              // ),
              ),
        ));
  }

  Widget _bottonLogin2() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // ignore: deprecated_member_use
        return RaisedButton(
            // ignore: deprecated_member_use
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Text(
                'Pagar',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 10.0,
            color: Colors.amber,
            onPressed: () {
              _alerta();
            });
      },
    );
  }

  void _alerta() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text(''),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Seguro que desea realizar a compra!!'),
          FlutterLogo(
            size: 100.0,
          )
        ]),
        actions: [
          TextButton(
            onPressed: () {
              msgListaPedido();
            },
            child: Text(
              'SI',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  void msgListaPedido() async {
    String pedido = "";
    String fecha = DateTime.now().toString();
    pedido = pedido + "FECHA:" + fecha.toString();
    pedido = pedido + "\n";
    pedido = pedido + "Taller MotoAStiven ";
    pedido = pedido + "\n";
    pedido = pedido + "CLIENTE:";
    pedido = pedido + "\n";
    pedido = pedido + "_____________";

    for (int i = 0; i < _cart.length; i++) {
      pedido = '$pedido' +
          "\n" +
          "Producto : " +
          _cart[i].nombre +
          "\n" +
          "Cantidad: " +
          _cart[i].cantidad.toString() +
          "\n" +
          "Precio : " +
          _cart[i].preciocompra.toString() +
          "\n" +
          "\_________________________\n";
    }
    pedido = pedido + "TOTAL:" + valorTotal(_cart);

    await launch("https://wa.me/${573043314456}?text=$pedido");
  }
}
