import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/models/poductos-models.dart';
import 'package:proyecto_final/services/firebase_services.dart';

class detalleproducto extends StatefulWidget {
 
   late final ProductosModel producto ;
   

  detalleproducto(this.producto);

  @override
  _detalleproductoState createState() => _detalleproductoState();
}

class _detalleproductoState extends State<detalleproducto> {



FirebaseService db = new FirebaseService();


  @override
  Widget build(BuildContext context) {
     
    
                return Scaffold(
                   appBar: AppBar(
                  title: Text('Detalle Repuesto'),
                 ),

                 body: Container(
                   height: 600,
                   width: 600,
                   child: Center(
                     child: Expanded(
                       child: Container(
                         height: 800,
                         width: 800,
                         child: Center(
                           child: Card(
                                      elevation: 4.0,
                                      child: Stack(
                                        fit: StackFit.loose,
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                height: 400,
                                                width: 800,
                                                child: CachedNetworkImage(
                                                    imageUrl:
                                                        '${widget.producto.imagen}' +
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
                                                'Nombre:  ${widget.producto.nombre}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 20.0),
                                              ),
                                               Text(
                                                 'Precio:${widget.producto.pricioVenta(widget.producto.preciocompra).toString()}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 20.0),
                                              ),
                                               Text(
                                                'Cantidad:  ${widget.producto.cantidadProducto}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 20.0),
                                              ),
                                               Text(
                                                'marca:  ${widget.producto.marca}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 20.0),
                                              ),
                                          
                                              SizedBox(
                                                height: 15,
                                              ),
                                              
                                        
                                              
                                            ],
                                          ),

                                          Row(children: [

                                            Padding(
                                              padding: const EdgeInsets.only(
                                              right: 12.0,
                                                bottom: 12.0,
                                            ),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: GestureDetector(
                                                child:
                                                    
                                                        Icon(
                                                            Icons.drive_file_rename_outline_outlined,
                                                            color: Colors.green,
                                                            size: 38,
                                                          ),
                                                      
                                                onTap: () {
                                                  setState(() {

                                                    
                                                  });
                                                },
                                              ),
                                            ),
                                        ),

                                         Padding(
                                              padding: const EdgeInsets.only(
                                              right: 12.0,
                                              bottom: 12.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: GestureDetector(
                                              child:
                                                  
                                                       Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                          size: 38,
                                                        ),
                                                     
                                              onTap: () {
                                                setState(() {
                                                  _eliminar();
                                                  
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                          ],)
                                          
                                        ],
                                      )),
                                      
                         ),
                       ),
                     ),

                   ),
                 ),
                  
                  

                  );
                  
                     
                        
                    
                      
                    
                    
     
    
  }



  void _eliminar() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text(''),
        content:Column(
          mainAxisSize: MainAxisSize.min,
        children: [
          Text('Seguro que desea  eliminar el repuesto!!:'  + widget.producto.nombre),
          FlutterLogo(size: 100.0,)
        ]
        ),
        
        actions: [
          TextButton(
            onPressed: () {
              
              setState(() {
                 FirebaseService.eliminarcliente(widget.producto.id);
              });
                                                
             
           
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


  


   

  
 

}