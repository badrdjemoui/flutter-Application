import 'package:flutter/material.dart';
import 'listpage.dart';
import 'sqldb.dart';


void main() => runApp( RunMyApp());

class RunMyApp extends StatelessWidget {
   RunMyApp({super.key});



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
  final myController6 = TextEditingController();
      // double cost =0.0;
       //String sale="";
  SqlDb sqlDb =  SqlDb();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    myController5.dispose();
    myController6.dispose();

    super.dispose();
  }
  String dropdownvalue = 'مينو';

  // List of items in our dropdown menu
  var items = [
    'مينو',
    'سليم',
    'غاني',
    'هاني',
    'خيرو',
    'بلال',
    'حمزة',

  ];


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
/************************************/
               DropdownButton(

                 // Initial Value
                 value: dropdownvalue,

                 // Down Arrow Icon
                 icon: const Icon(Icons.keyboard_arrow_down),

                 // Array list of items
                 items: items.map((String items) {
                   return DropdownMenuItem(
                     value: items,
                     child: Text(items),
                   );
                 }).toList(),
                 // After selecting the desired option,it will
                 // change button value to selected value
                 onChanged: (String? newValue) {

                   myController1.text=(dropdownvalue).toString();

                   setState(() {
                     dropdownvalue = newValue!;
                   });
                 },
               ),

/************************************/

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
               /****************************************/
               TextFormField(
        controller: myController5,
        keyboardType: TextInputType.number,
    decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'وزن الكلغ ',
    )
    ),

               /**************** /row ************************/
       Row(
        children: <Widget>[
          /**************** /Button ************************/
               MaterialButton(

        onPressed:()
              async {
 double cost = double.parse(myController4.text)*double.parse(myController5.text);
String sale =myController1.text+" I "+myController2.text+" I "+myController3.text+" I "+myController4.text+" I "+myController5.text+" I "+cost.toString();

       String sql= "INSERT INTO "+"'sales' "+"('txt')"+" VALUES "+"('"+sale.toString()+"')";

       int response = await sqlDb.insertData(sql);

       print('excuted badr '+response.toString());

        showDialog( context: context,
                    builder: (context) {
                       return AlertDialog(
                       // Retrieve the text that user has entered by using the
                       // TextEditingController.
                        content: Text("  sale =   "+sale.toString()),
                                         );
                                     },
                             );
                  },

               child: Text('حساب وحفظ'),
                 color:Color(0xFFB9F6CA),
                 height: 30,
                 textColor:Color(0xFFFF6F00),
                 //shape: ,

               ),
          /****************** button/ **********************/
          VerticalDivider(
           // color: Colors.black,
            thickness: 400,
          ),
          /**************** /Button ************************/
          MaterialButton(

            onPressed:()
            async {

              String sql= "SELECT * from 'sales'";

             List<Map> response = await sqlDb.readData(sql);

              print('data '+response.toString());

              showDialog( context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text that user has entered by using the
                    // TextEditingController.
                    content: Text("  sale =   "+response.toString()),
                  );
                },
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>   Listpage()),
              );
            },

            child: Text('عرض'),
            color:Color(0xFFB9F6CA),
            height: 30,
            textColor:Color(0xFFFF6F00),
            //shape: ,

          ),
          /****************** button/ **********************/


          /****************************************/
        ],
      ) ,
      /****************  row/ ************************/

               /**************** /row ************************/
               Row(
                 children: <Widget>[

                   /**************** /Button ************************/
                   MaterialButton(

                     onPressed:()
                     async {

                       String sql= "DELETE from 'sales' WHERE id = "+myController6.text;

                       List<Map> response = await sqlDb.deleteData(sql);

                       print('data '+response.toString());

                       showDialog( context: context,
                         builder: (context) {
                           return AlertDialog(
                             // Retrieve the text that user has entered by using the
                             // TextEditingController.
                             content: Text("  sale =   "+response.toString()),
                           );
                         },
                       );
                     },

                     child: Text('حذق برقم السجل'),
                     color:Color(0xFFB9F6CA),
                     height: 30,
                     textColor:Color(0xFFFF6F00),
                     //shape: ,

                   ),

                   /****************** button/ **********************/
                    SizedBox(
                     width: 100.0,
                     child:TextFormField(
                       controller: myController6,
                       keyboardType: TextInputType.number,
                       decoration: const InputDecoration(
                         border: UnderlineInputBorder(),
                         labelText: ' عدد السجل المراد حذفه او تغييره ',

                       )
                     ),
                   ),


                   /**************** /Button ************************/
                   MaterialButton(

                     onPressed:()
                     async {
                       double cost = double.parse(myController4.text)*double.parse(myController5.text);
                       String sale =myController1.text+" I "+myController2.text+" I "+myController3.text+" I "+myController4.text+" I "+myController5.text+" I "+cost.toString();
                       String sql= "UPDATE 'sales' SET 'txt' = '"+sale.toString()+"' WHERE id = "+myController6.text;

                       int response = await sqlDb.updateData(sql);

                       print('data '+response.toString());

                       showDialog( context: context,
                         builder: (context) {
                           return AlertDialog(
                             // Retrieve the text that user has entered by using the
                             // TextEditingController.
                             content: Text("  sql =   "+sql+" response "+response.toString()),
                           );
                         },
                       );
                     },

                     child: Text('تحيين المعلومات'),
                     color:Color(0xFFB9F6CA),
                     height: 30,
                     textColor:Color(0xFFFF6F00),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(
                         32.0,
                       ),
                     ),

                   ),
                   /****************** button/ **********************/

                   /****************************************/
                 ],
               ) ,
               /****************  row/ ************************/

    ],
    ) ,


                    );

  }



  
}