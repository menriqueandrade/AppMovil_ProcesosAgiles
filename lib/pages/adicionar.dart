
import 'package:flutter/material.dart';
import 'package:proyecto_final/services/clinetehttp.dart';

class AgregarMensajero extends StatefulWidget {
  @override
  _AgregarMensajeroState createState() => _AgregarMensajeroState();
}

class _AgregarMensajeroState extends State<AgregarMensajero> {
  TextEditingController controlNombre = TextEditingController();
  TextEditingController controlfoto = TextEditingController();
  TextEditingController controlplaca = TextEditingController();
  TextEditingController controltelefono = TextEditingController();
  TextEditingController controlwhatsapp = TextEditingController();
  TextEditingController controlmoto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Cliente"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[

               Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                
                controller: controlNombre,
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
                       controlNombre.clear();
                      },
                    )
                    //probar suffix
                    ),
              ),
            ),
              Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                
                controller: controlplaca,
                decoration: InputDecoration(
                   border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20.0)
                    ),
                    filled: true,
                    labelText: 'Apellido',
                      suffixIcon: Icon(Icons.accessibility_outlined),
                      icon: Icon(Icons.create),
                       fillColor: Colors.white,
                    // suffix: Icon(Icons.access_alarm),
                    suffix: GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                       controlplaca.clear();
                      },
                    )
                    //probar suffix
                    ),
              ),
            ),

             Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                
                controller: controltelefono,
                decoration: InputDecoration(
                   border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20.0)
                    ),
                    filled: true,
                    labelText: 'Direccion',
                      suffixIcon: Icon(Icons.accessibility_outlined),
                      icon: Icon(Icons.create),
                       fillColor: Colors.white,
                    // suffix: Icon(Icons.access_alarm),
                    suffix: GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                       controltelefono.clear();
                      },
                    )
                    //probar suffix
                    ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                
                controller: controlwhatsapp,
                decoration: InputDecoration(
                   border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20.0)
                    ),
                    filled: true,
                    labelText: 'Telefono',
                      suffixIcon: Icon(Icons.accessibility_outlined),
                      icon: Icon(Icons.create),
                       fillColor: Colors.white,
                    // suffix: Icon(Icons.access_alarm),
                    suffix: GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                       controlwhatsapp.clear();
                      },
                    )
                    //probar suffix
                    ),
              ),
            ),

             Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                
                controller: controlmoto,
                decoration: InputDecoration(
                   border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20.0)
                    ),
                    filled: true,
                    labelText: 'Cedula',
                      suffixIcon: Icon(Icons.accessibility_outlined),
                      icon: Icon(Icons.create),
                       fillColor: Colors.white,
                    // suffix: Icon(Icons.access_alarm),
                    suffix: GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                       controlmoto.clear();
                      },
                    )
                    //probar suffix
                    ),
              ),
            ),
            
              // TextField(
              //   controller: controlNombre,
              //   decoration: InputDecoration(labelText: "Nombre"),
              // ),
              
              // TextField(
              //   controller: controlplaca,
              //   decoration: InputDecoration(labelText: "Apellido"),
              // ),
              // TextField(
              //   controller: controltelefono,
              //   decoration: InputDecoration(labelText: "direccion"),
              // ),
              // TextField(
              //   controller: controlwhatsapp,
              //   decoration: InputDecoration(labelText: "telefono"),
              // ),
              // TextField(
              //   controller: controlmoto,
              //   decoration: InputDecoration(labelText: "Cedula"),
              // ),
              ElevatedButton(
                child: Text("Registrar"),
                onPressed: () {

                  if (controlNombre.text.isNotEmpty && controlplaca.text.isNotEmpty &&
                    controltelefono.text.isNotEmpty &&controlwhatsapp.text.isNotEmpty &&
                    controlmoto.text.isNotEmpty) {
               

                   var cliente = <String, dynamic>{
                    'nombrecliente': controlNombre.text,
                    'apellidocliente': controlplaca.text,
                    'direccioncliente': controltelefono.text,
                    'telefonocliente': controlwhatsapp.text,
                    'cedula': controlmoto.text,
                  };

                  Peticiones.crearcliente(cliente);

                  Navigator.pop(context);

                  // Devuelvo los datos de la lista _clientesadd
                   
                 // Navigator.pop(context, _usuarioadd);
                }else{
                  _alerta();
                }
                  
                },
              ),
            ],
          ),
        ),
      ),
    );
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
