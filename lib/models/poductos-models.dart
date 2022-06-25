import 'package:flutter/material.dart';

class ProductosModel {

  

 late  String id='0';
 late  String nombre;
 late  String imagen;
 late  int preciocompra=0;
 late int cantidad=1;
 late String categoria='';
 late String marca='';
 late int cantidadProducto=0;

  ProductosModel(
    
    String documentID,
    String nombre,
     String imagen,
     int preciocompra,
     String categoria,
     String marca,
     int cantidadProducto,
  );

  ProductosModel.map(dynamic obj) {
    this.id = obj['id'];
    this.nombre = obj['nombre'];
    this.imagen = obj['imagen'];
    this.preciocompra = obj['preciocompra'];
    this.categoria = obj['categoria'];
    this.marca = obj['marca'];
    this.cantidadProducto = obj['cantidadProducto'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['id'] = id;
    map['nombre'] = nombre;
    map['imagen'] = imagen;
    map['preciocompra'] = preciocompra; 
    map['categoria'] = categoria;
    map['marca'] = marca;
    map['cantidadProducto'] = cantidadProducto;

    return map;
  }

  ProductosModel.fromMap(Map<dynamic, dynamic> map) {

    this.id = map['id'].toString();
    this.nombre = map['nombre'];
    this.imagen = map['imagen'];
    this.preciocompra = map['preciocompra'];
    this.categoria = map['categoria'];
    this.marca = map['marca'];
    this.cantidadProducto = map['cantidadProducto'];

  }

  
  double pricioVenta(preciocompra){
    var iva = 0.19;
    var priceventa = preciocompra*iva;
    var pricesuma=preciocompra+priceventa;
  
    return pricesuma;
  }
}








