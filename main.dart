import 'package:flutter/material.dart';
import 'sqldb.dart';


void main() => runApp( RunMyApp());

class RunMyApp extends StatelessWidget {
   RunMyApp({super.key});

  SqlDb db = new SqlDb();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Retrieve Text Input',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class. This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value of the TextField.
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();
       double cost =0.0;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    myController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

                           appBar:
                               AppBar(title: const Center(
                                 child: Text(" الدجاج المذبوح",style:TextStyle(
                                   // color:Color.fromRGBO(20, 200, 240, 20),
                                    color: Colors.blueAccent,
                                       //   color: Color(0xff3400db),
                                   fontSize: 22.2,
                                   fontWeight: FontWeight.bold,
                                     backgroundColor: Colors.white60),
                                        ))),
                           body:
                           /*const Text("djemoui badr",style:TextStyle(
                                     // color:Color.fromRGBO(20, 200, 240, 20),
                                      color: Colors.greenAccent,
                                     //   color: Color(0xff3400db),
                                        fontSize: 60.2,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: Colors.amberAccent,

                                                                        )
                                         ),
    */
  Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: <Widget>[

               TextFormField(
                   controller: myController1,
                   decoration: const InputDecoration(
                     border: UnderlineInputBorder(),
                     labelText: ' اسم الزبون ',
                   )
               ),

               TextFormField(
                   controller: myController2,
                   decoration: const InputDecoration(
                     border: UnderlineInputBorder(),
                     labelText: ' التاريخ ',
                   )
               ),

   TextFormField(
       controller: myController3,
   keyboardType: TextInputType.number,
         decoration: const InputDecoration(
           border: UnderlineInputBorder(),
            labelText: ' العدد ',

           )
         ),

    TextFormField(
        controller: myController4,
        keyboardType: TextInputType.number,
    decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'الوزن الكلي',
    )
    ),
    TextFormField(
        controller: myController5,
        keyboardType: TextInputType.number,
    decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'وزن الكلغ ',
    )
    ),
               MaterialButton(

                              onPressed:()
                                     {
cost = double.parse(myController4.text)*double.parse(myController5.text);
                             showDialog(
                                              context: context,
                                             builder: (context) {
                                                         return AlertDialog(
                       // Retrieve the text that user has entered by using the
                       // TextEditingController.
                                                            content: Text(cost.toString()),
                                                                     );
                                     },
                             );


               },
               child: Text('حساب '),
                 color:Color(0xFFB9F6CA),
                 height: 30,
                 textColor:Color(0xFFFF6F00),
                 //shape: ,

               )
    ],
    ) ,


                    );

  }



  
}