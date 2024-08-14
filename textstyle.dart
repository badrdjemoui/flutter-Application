import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return MaterialApp(

                       home:Scaffold
                         (
                           appBar:AppBar(title: Text("العنوان")),
                           body:Text("djemoui badr",style:TextStyle(
                                     // color:Color.fromRGBO(20, 200, 240, 20),
                                      color: Colors.greenAccent,
                                     //   color: Color(0xff3400db),
                                        fontSize: 60.2,

                           )
                           ),
                         )

                    );

  }

  
}