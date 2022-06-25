

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final/models/poductos-models.dart';
import 'dart:async';

final CollectionReference productCollection =
    FirebaseFirestore.instance.collection('repuestoss');

class FirebaseService {
  static final FirebaseService _instance = new FirebaseService.internal();
  factory FirebaseService() => _instance;

  FirebaseService.internal();

  Future<ProductosModel> createProduct(
     
     String nombre,
     String imagen,
     int preciocompra,
     int cantidad,
     String categoria,
     String marca,
     int cantidadProducto,) {
       
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot doc = await tx.get(productCollection.doc());

      final ProductosModel producto =
          new ProductosModel(doc.id,nombre,imagen, preciocompra,categoria,marca,cantidadProducto);
      final Map<String, dynamic> data = producto.toMap();

      await tx.set(doc.reference, data);

      return data;
    };

    return FirebaseFirestore.instance.runTransaction(createTransaction).then((mapData) {
      return ProductosModel.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getProductList({int offset=0, int limit=0}) {
    Stream<QuerySnapshot> snapshot = productCollection.snapshots();

    if (offset != null) {
      snapshot = snapshot.skip(offset);
    }

    if (limit != null) {
      snapshot = snapshot.skip(limit);
    }

    return snapshot;
  }

static Future<void> eliminarcliente(String id) async {
    await productCollection.doc(id).delete().catchError((e) {
      print(e);
    });
    //return true;
  }

  


  

  
}


