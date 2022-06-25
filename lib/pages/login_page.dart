import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/models/login.dart';
import 'package:proyecto_final/pages/principal.dart';
//import 'package:parcial/src/models/login.dart';
//import 'package:parcial/src/pages/listar_page.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

   late TextEditingController controladorcorreo;
   late TextEditingController controladorcontrasenia;
   
   String contra = '1';
   String correo ='1';
    List _sesion = sesion;
    bool bandera = false;

     @override
    void initState() {

     controladorcorreo= TextEditingController();
     controladorcontrasenia= TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     
    return SafeArea(
      child: Scaffold(

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: CircleAvatar(
              // backgroundImage:NetworkImage('https://www.ubika.com.co/wp-content/uploads/2019/02/urbanmotors-1.jpg'),
                child: Image.asset('assets/images/2.jpeg'),
                radius: 100.0,
                ),
              ),
               
               SizedBox(height: 15.0,),
               _UserTextfield(),
                SizedBox(height: 15.0,),
                _passwordTextfield(),
                 SizedBox(height: 20.0,),
                 //_bottonLogin(),
                  SizedBox(height: 20.0,),
                 _bottonLogin2(),



            
            ],
            
            
          ),
        ),

    ));
  }

 Widget _UserTextfield() {

   return StreamBuilder(
     builder: (BuildContext context, AsyncSnapshot snapshot) {
       return Container(
         padding: EdgeInsets.symmetric(horizontal: 35.0),
         child: TextField(
           controller: controladorcorreo,
           keyboardType: TextInputType.emailAddress,
           decoration: InputDecoration(

             icon: Icon(Icons.email),
             hintText: 'ejemplo@correo.com',
             labelText: 'Correo Eletronico '

           ),
           onChanged: (value){
             
           },
         ),
       );
     },
   );
 }

 Widget _passwordTextfield() {

   return StreamBuilder(
     builder: (BuildContext context, AsyncSnapshot snapshot) {
       return Container(
         padding: EdgeInsets.symmetric(horizontal: 35.0),
         child:  TextField(
           controller: controladorcontrasenia,
           obscureText: true,
           decoration: InputDecoration(
             icon: Icon(Icons.lock),
             hintText: 'Contraseña',
             labelText: 'contraseña '

           ),
           onChanged: (value){
             
           },
         ),
       );
     },
   );

 }

//  Widget  _bottonLogin() {

//     return StreamBuilder(
     
//       builder: (BuildContext context, AsyncSnapshot snapshot) {

//         // ignore: deprecated_member_use
//         return RaisedButton(
//           // ignore: deprecated_member_use
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
//             child: Text('iniciar sesion',
//             style: TextStyle(
//               fontSize: 16.0,
//               fontWeight: FontWeight.bold
//             ),
//             ),
            

//           ),

//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30)
//           ),

//           elevation: 10.0,
//           color:Colors.amber,
//            onPressed:(){
//              print(controladorcorreo.text);
//              print(controladorcontrasenia.text);
            
//              if ( controladorcorreo.text.isNotEmpty &&
//                     controladorcontrasenia.text.isNotEmpty ) {
//                   // Agregar a la lista los valores de cada texto
//                   if(controladorcorreo.text == correo && controladorcontrasenia.text == contra){

//                     controladorcorreo.text='';
//                     controladorcontrasenia.text='';
//                      // _alerta1();
//                                 Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) =>
//                             listarPage(correo)//Llamar la Vista TextoEjercicio
//                       ),
//                     ).then((resultado) //Espera por un Resultado
//                         {
                     
//                           //Adiciona a la lista lo que recupera de la vista TextoEjercicio
//                       setState(() {});
//                     });

//                   }else{
//                     _alerta2();
//                     controladorcorreo.text='';
//                     controladorcontrasenia.text='';
//                   }

//                 }else{
//                   _alerta();
              
//                 }

             
//            }
            
//         );
        
//       },
//     );

//   }

  Widget  _bottonLogin2() {

    return StreamBuilder(
     
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        // ignore: deprecated_member_use
        return RaisedButton(
          // ignore: deprecated_member_use
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            child: Text('iniciar sesion',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold
            ),
            ),
            

          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),

          elevation: 10.0,
          color:Colors.amber,
           onPressed:(){
            
            
             if ( controladorcorreo.text.isNotEmpty &&
                    controladorcontrasenia.text.isNotEmpty ) {
                  
                 
                 sesion.forEach((element) { 
                  
                  if(controladorcorreo.text == element.correo && controladorcontrasenia.text == element.contrasenia){
                        bandera=true;
                    
                        validarSesion(element.correo);               

                  }

                 });

                 if(bandera==false){
                      _alerta2();
                      print('hola');
                      
                 }

                 

                }else{
                  _alerta();
              
                }
             bandera=false;
             
           }
            
        );
        
      },
    );

  }

 void validarSesion(correo){

  if(bandera==true){

        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            Principal()//Llamar la Vista TextoEjercicio
                      ),
                    ).then((resultado) //Espera por un Resultado
                        {
                     
                          //Adiciona a la lista lo que recupera de la vista TextoEjercicio
                      setState(() {});
                    });
  }




 }



 void _alerta() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text(''),
        content:Column(
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

  void _alerta1() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        
        title: Text(''),
        content: Text('inicio correctamente'),
        
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


  void _alerta2() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text(''),
        content: Column(
          mainAxisSize: MainAxisSize.min,
        children: [
          Text('Correo o contraseña incorrecta'),
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
