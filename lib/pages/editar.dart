//import 'package:ejemplo10_firebase_crud/peticiones/mensajeroshttp.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/services/clinetehttp.dart';

class ModificarMensajero extends StatefulWidget {
  final iddoc;
  final pos;
  final List perfil;
  ModificarMensajero({required this.perfil, this.pos, this.iddoc});

  @override
  _ModificarMensajeroState createState() => _ModificarMensajeroState();
}

class _ModificarMensajeroState extends State<ModificarMensajero> {
  TextEditingController controlNombre = TextEditingController();
  TextEditingController controlfoto = TextEditingController();
  TextEditingController controlplaca = TextEditingController();
  TextEditingController controltelefono = TextEditingController();
  TextEditingController controlwhatsapp = TextEditingController();
  TextEditingController controlmoto = TextEditingController();

  bool soat = false;
  bool tecno = false;
  bool activo = false;
  late String soattxt;
  late String tecnotxt;
  late String activotxt;

  @override
  void initState() {
    controlNombre =
        TextEditingController(text: widget.perfil[widget.pos]['nombrecliente']);
  
    controlplaca = TextEditingController(
        text: widget.perfil[widget.pos]['apellidocliente']);
    controltelefono = TextEditingController(
        text: widget.perfil[widget.pos]['direccioncliente']);
    controlwhatsapp = TextEditingController(
        text: widget.perfil[widget.pos]['telefonocliente']);
    

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Cliente"),
        actions: [
          IconButton(
              tooltip: 'Eliminar Cliente',
              icon: Icon(Icons.delete),
              onPressed: () {
                Peticiones.eliminarcliente(widget.perfil[widget.pos].id);

                Navigator.pop(context);
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              TextField(
                controller: controlNombre,
                decoration: InputDecoration(labelText: "Nombre"),
              ),
              
              TextField(
                controller: controlplaca,
                decoration: InputDecoration(labelText: "Apellido"),
              ),
              TextField(
                controller: controltelefono,
                decoration: InputDecoration(labelText: "direccion"),
              ),
               TextField(
                 controller: controlwhatsapp,
                 decoration: InputDecoration(labelText: "telefono"),
               ),
             
              ElevatedButton(
                child: Text("Modificar Cliente"),
                onPressed: () {
                  var cliente = <String, dynamic>{
                    'nombrecliente': controlNombre.text,
                   
                    'apellidocliente': controlplaca.text,
                    'direccioncliente': controltelefono.text,
                     'telefonocliente': controlwhatsapp.text,
                    
                  };

                  Peticiones.actualizarcliente(
                      widget.perfil[widget.pos].id, cliente);

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
