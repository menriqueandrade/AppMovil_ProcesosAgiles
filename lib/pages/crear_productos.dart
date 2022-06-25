import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:modal_progress_hud/modal_progress_hud.dart';

class CommonThings {
  late Size size;
}

class CrearProductos extends StatefulWidget {
  final id;
  CrearProductos({this.id});

  @override
  _CrearProductosState createState() => _CrearProductosState();
}

enum SelectSource { camara, galeria }

class _CrearProductosState extends State<CrearProductos> {
  File? _foto;
   var urlFoto;
  bool _isInAsyncCall = false;
  late int preciocompra = 0;
  int cantidad = 0;
  late var categoria = " ";
  late var marca=" ";
  late var cantidadProducto = 2;
  //Auth auth = Auth();

  late TextEditingController nombreInputController;
  late TextEditingController imageInputController;
  late TextEditingController precioCompraInputController;
  late TextEditingController categoriaInputController;
  late TextEditingController marcaInputController;
  late TextEditingController cantidadProductoInputController;

   @override
  void initState() {
     nombreInputController= TextEditingController() ;
     imageInputController= TextEditingController();
     precioCompraInputController=TextEditingController();
     categoriaInputController= TextEditingController() ;
     marcaInputController=TextEditingController();
     cantidadProductoInputController= TextEditingController() ;

    super.initState();
    
  }

  var id;
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  late var nombre;
  var uid;


  Future captureImage(SelectSource opcion) async {
    var image;
    final imagePicker = ImagePicker();
    opcion == SelectSource.camara
        // ignore: deprecated_member_use
        ? image = await imagePicker.getImage(source: ImageSource.camera)
        // ignore: deprecated_member_use
        : image = await imagePicker.getImage(source: ImageSource.gallery);

 

    setState(() {
      _foto = File(image.path);
    });
  }

  Future getImage() async {
    AlertDialog alerta = new AlertDialog(
      content: Text('Seleccione de donde desea capturar la imagen'),
      title: Text('Seleccione Imagen'),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: () {
            // seleccion = SelectSource.camara;
            captureImage(SelectSource.camara);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Row(
            children: <Widget>[Text('Camara'), Icon(Icons.camera)],
          ),
        ),
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: () {
            // seleccion = SelectSource.galeria;
            captureImage(SelectSource.galeria);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Row(
            children: <Widget>[Text('Galeria'), Icon(Icons.image)],
          ),
        )
      ],
    );
    showDialog(builder: (context) => alerta, context: context);
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }

  bool _validarlo() {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _enviar() {
    if (_validarlo()) {
      setState(() {
        _isInAsyncCall = true;
      });

      // ignore: unnecessary_null_comparison
      if (_foto != null) {
        FirebaseStorage storage = FirebaseStorage.instance;
        String url;
        Reference ref =
            storage.ref().child("image1" + DateTime.now().toString());
        UploadTask uploadTask = ref.putFile(_foto!);
        uploadTask.then((onValue) {
          onValue.ref.getDownloadURL().then((onValue) {
            setState(() {
              urlFoto = onValue.toString();
              FirebaseFirestore.instance
                  .collection('repuestoss')
                  .add({
                    'nombre':nombreInputController.text,
                    'imagen':urlFoto,
                    'preciocompra': int.parse( precioCompraInputController.text),
                    'categoria':categoriaInputController.text,
                    'marca':marcaInputController.text,
                    'cantidadProducto':int.parse(cantidadProductoInputController.text),
                  })
                  .then((value) => Navigator.of(context).pop())
                  .catchError(
                      (onError) => print('Error al registrar su produtos bd'));
              _isInAsyncCall = false;
            });
          });
        });
      } else {
        FirebaseFirestore.instance
            .collection('repuestoss')
            .add({
                    'nombre':nombreInputController.text,
                    'imagen':urlFoto,
                    'preciocompra': int.parse( precioCompraInputController.text) ,
                    'categoria':categoriaInputController.text,
                    'marca':marcaInputController.text,
                    'cantidadProducto':int.parse(cantidadProductoInputController.text) ,
            })
            .then((value) => Navigator.of(context).pop())
            .catchError((onError) => print('Error al registrar su receta bd'));
        _isInAsyncCall = false;
      }
    } else {
      print('objeto no validado');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Repuestos'),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isInAsyncCall,
          opacity: 0.5,
          dismissible: false,
          progressIndicator: CircularProgressIndicator(),
          color: Colors.blueGrey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 10, right: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: GestureDetector(
                          onTap: getImage,
                        ),
                        margin: EdgeInsets.only(top: 20),
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.black),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,

                                // ignore: unnecessary_null_comparison
                                image: _foto == null
                                    ? AssetImage("assets/images/reloj.gif")
                                        as ImageProvider
                                    : FileImage(_foto!))),
                      )
                    ],
                  ),
                  Text('click para cambiar foto'),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                 Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                
                controller: nombreInputController,
                decoration: InputDecoration(
                   border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20.0)
                    ),
                    filled: true,
                    labelText: 'Nombre',
                      suffixIcon: Icon(Icons.accessibility_outlined),
                      icon: Icon(Icons.create),
                       fillColor: Colors.white,
                    // suffix: Icon(Icons.access_alarm),
                    suffix: GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                        nombreInputController.clear();
                      },
                    )
                    //probar suffix
                    ),
              ),
            ),
               Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                 keyboardType: TextInputType.number,
                controller: precioCompraInputController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20.0)
                    ),
                    filled: true,
                    labelText: 'Precio de Compra',
                    suffixIcon: Icon(Icons.date_range),
                    icon: Icon(Icons.date_range),
                     fillColor: Colors.white,
                    // suffix: Icon(Icons.access_alarm),
                    suffix: GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                        precioCompraInputController.clear();
                      },
                      
                    )
                    //probar suffix
                    ),
              ),
            ),
                  Padding(
                   padding: EdgeInsets.all(15.0),
                    child: TextField(
                
                controller: categoriaInputController,
                decoration: InputDecoration(
                   border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20.0)
                    ),
                    filled: true,
                    labelText: 'Categoria',
                      suffixIcon: Icon(Icons.accessibility_outlined),
                      icon: Icon(Icons.create),
                       fillColor: Colors.white,
                    // suffix: Icon(Icons.access_alarm),
                    suffix: GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                        categoriaInputController.clear();
                      },
                    )
                    //probar suffix
                    ),
              ),
            ),
                   Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                
                controller: marcaInputController,
                decoration: InputDecoration(
                   border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20.0)
                    ),
                    filled: true,
                    labelText: 'Marca',
                      suffixIcon: Icon(Icons.accessibility_outlined),
                      icon: Icon(Icons.create),
                       fillColor: Colors.white,
                    // suffix: Icon(Icons.access_alarm),
                    suffix: GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                        marcaInputController.clear();
                      },
                    )
                    //probar suffix
                    ),
              ),
            ),
                    Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                 keyboardType: TextInputType.number,
                controller: cantidadProductoInputController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20.0)
                    ),
                    filled: true,
                    labelText: 'Cantidad',
                    suffixIcon: Icon(Icons.date_range),
                    icon: Icon(Icons.date_range),
                     fillColor: Colors.white,
                    // suffix: Icon(Icons.access_alarm),
                    suffix: GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                        cantidadProductoInputController.clear();
                      },
                    )
                    //probar suffix
                    ),
              ),
            ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // ignore: deprecated_member_use
                      RaisedButton(
                        onPressed:  Registrar,
                        child: Text('Registrar',
                            style: TextStyle(color: Colors.white)),
                        color: Colors.green,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void Registrar(){

     if (nombreInputController.text.isNotEmpty && precioCompraInputController.text.isNotEmpty &&
                    categoriaInputController.text.isNotEmpty &&marcaInputController.text.isNotEmpty &&
                    cantidadProductoInputController.text.isNotEmpty) {
               

                   _enviar();

                  // Devuelvo los datos de la lista _clientesadd
                   
                 // Navigator.pop(context, _usuarioadd);
                }else{
                  _alerta();
                }
  }
  void _alerta() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text(''),
        content: Column(
          mainAxisSize: MainAxisSize.min,
        children: [
          Text('por favor llenar todos los campos!!'),
          FlutterLogo(size: 100.0,)
        ]
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
           
       
              });
              Navigator.pop(context);
            },
            child: Text(
              'ok',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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
}
