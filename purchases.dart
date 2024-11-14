import 'package:flutter/material.dart';
import 'listpurch.dart';

import 'sqldb.dart';
import 'main.dart';


class Purchases extends StatelessWidget {
  const Purchases({super.key});



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Retrieve Text Input',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: const MyCustomForPur(),
    );
  }
}


class MyCustomForPur extends StatefulWidget {
  const MyCustomForPur({super.key});

  @override
  State<MyCustomForPur> createState() => _MyCustomFormStatPur();
}


class _MyCustomFormStatPur extends State<MyCustomForPur> {

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();
  final myController6 = TextEditingController();
  final myController7 = TextEditingController();
  final myController8 = TextEditingController();


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
    myController7.dispose();
    myController8.dispose();

    super.dispose();
  }
   ///************************initState*********************************** */

 @override
  void initState() {
    super.initState();
     myController2.text="${DateTime.now().subtract(const Duration(days:1)).day}/${DateTime.now().subtract(const Duration(days:1)).month}/${DateTime.now().subtract(const Duration(days:1)).year}";
     myController8.text='0.0';
     myController6.text='0.0'; 
             
  }
             
  
  ///************************************************************* */
  String dropdownvalue1 = 'لحمودي';

  // List of items in our dropdown menu
  var items1 = [
    'مينو',
    'سوفي حداد',
    'لحمودي',


  ];

///************************************************************************ */
  @override
  Widget build(BuildContext context) {

    return Scaffold(

                           appBar:
                               AppBar(title: const Center(
                                 child: Text(" الدجاج الحي",style:TextStyle(
                                   // color:Color.fromRGBO(20, 200, 240, 20),
                                    color: Colors.blueAccent,
                                       //   color: Color(0xff3400db),
                                   fontSize: 22.2,
                                   fontWeight: FontWeight.bold,
                                     backgroundColor: Colors.white60),
                                        ))),
                           body:

 SingleChildScrollView(child:
      Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   mainAxisSize: MainAxisSize.min,
   children: <Widget>[

               TextFormField(
                   controller: myController1,
                   textAlign: TextAlign.center,
                   decoration: const InputDecoration(
                     border: UnderlineInputBorder(),
                     hintText: ' اسم المربي ',
                   )
               ),
///******************  /SizedBox ******************/
      SizedBox(
        height: 50,
        child:DropdownButton(
                 value: dropdownvalue1,
                 icon: const Icon(Icons.keyboard_arrow_down),
                 items: items1.map((String items) {
                      return DropdownMenuItem(
                     value: items,
                     child: Text(items),
                   );
                 }).toList(),
                 onChanged: (String? newValue) {
                      setState(() {
                    dropdownvalue1 = newValue!;
                     myController1.text=dropdownvalue1.toString();
                   });
                 },

               ),
      ),

///*****************TextFormField*******************/
      TextFormField(
        controller: myController2,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: ' التاريخ ',
        ),
      ),
     /****************************************/
      TextFormField(
       controller: myController3,
          textAlign: TextAlign.center,
   keyboardType: TextInputType.number,
         decoration: const InputDecoration(
           border: UnderlineInputBorder(),
           hintText: ' العدد الكلي للدجاج',

           )
         ),
     ///****************************************/
    TextFormField(
        controller: myController4,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
    decoration: const InputDecoration(
    border: UnderlineInputBorder(),
      hintText: 'سعر الكلغ',
    )
    ),
 ///****************************************/
               TextFormField(
        controller: myController5,
                   textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
    decoration: const InputDecoration(
    border: UnderlineInputBorder(),
      hintText: 'الوزن الكلي ',
    )
    ),
     /****************************************/
     /****************************************/
     TextFormField(
         controller: myController6,
         textAlign: TextAlign.center,
         keyboardType: TextInputType.number,
         decoration: const InputDecoration(
           border: UnderlineInputBorder(),
           hintText: 'الوزن المسترجع',
         )
     ),
     /****************************************/
     TextFormField(
         controller: myController8,
         textAlign: TextAlign.center,
         keyboardType: TextInputType.number,
         decoration: const InputDecoration(
           border: UnderlineInputBorder(),
           hintText: 'دفع',
         )
     ),

     /**************** /row ************************/
       Row(
        children: <Widget>[
          /**************** /Button ************************/
               MaterialButton(

        onPressed:()
              async {
 double costpurch = double.parse(myController4.text)*(double.parse(myController5.text)-double.parse(myController6.text));



          
       String sql= "INSERT INTO purchases(nom,date,nbr,onekg,poid,some,vers) VALUES ('${myController1.text}','${myController2.text}','${myController3.text}','${myController4.text}','${myController5.text}','$costpurch','${myController8.text}')";

 
              

     



        showDialog( context: context,
                    builder: (context) {
                       return AlertDialog(
                       // Retrieve the text that user has entered by using the
                       // TextEditingController.
                        content: Text("  purchses =   $sql"),
                                         );
                                     },
                             );
                  },
                 color:const Color(0xFFB9F6CA),
                 height: 30,
                 textColor:const Color(0xFFFF6F00),

               child: const Text('حساب وحفظ'),
                 //shape: ,

               ),
          /****************** button/ **********************/
          const VerticalDivider(
           // color: Colors.black,
            thickness: 400,
          ),
          /**************** /Button ************************/
          MaterialButton(

            onPressed:()
            async {

              String sql= "SELECT * from 'purchases'";

             List<Map> response = await sqlDb.readData(sql);

          

              showDialog( context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text that user has entered by using the
                    // TextEditingController.
                    content: Text("  purchses =   $response"),
                  );
                },
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>   const ListPurch()),
              );
            },
            color:const Color(0xFFB9F6CA),
            height: 30,
            textColor:const Color(0xFFFF6F00),

            child: const Text(' عرض جميع المشتريات'),
            //shape: ,

          ),
       


///****************************************/
        ],
      ) ,

///****************  /row/ ************************/
               Row(
                 children: <Widget>[

 ///**************** /MaterialButton ************************/
                   MaterialButton(

                     onPressed:()
                     async {

                       String sql= "DELETE from 'purchses' WHERE id = ${myController7.text}";

                       List<Map> response = await sqlDb.deleteData(sql);

                  

                       showDialog( context: context,
                         builder: (context) {
                           return AlertDialog(
                             // Retrieve the text that user has entered by using the
                             // TextEditingController.
                             content: Text("  purchses =   $response"),
                           );
                         },
                       );
                     },
                     color:const Color(0xFFB9F6CA),
                     height: 30,
                     textColor:const Color(0xFFFF6F00),

                     child: const Text('حذق برقم السجل'),
                     //shape: ,

                   ),

///****************** SizedBox/ **********************/
                    SizedBox(
                     width: 100.0,
                     child:TextFormField(
                       controller: myController7,
                       keyboardType: TextInputType.number,
                       decoration: const InputDecoration(
                         border: UnderlineInputBorder(),
                         labelText: ' عدد السجل المراد حذفه او تغييره ',

                       )
                     ),
                   ),


 ///**************** /MaterialButton ************************/
                   MaterialButton(

                     onPressed:()
                     async {
                       double costpusrch = double.parse(myController4.text)*(double.parse(myController5.text)-double.parse(myController6.text));
                          String sql= "UPDATE 'purchses' SET 'nom' = '${myController1.text}','date' ='${myController2.text}','nbr' ='${myController3.text}','onekg' ='${myController4.text}','poid' ='${myController5.text}','some' ='$costpusrch' WHERE id = ${myController7.text}";

                       int response = await sqlDb.updateData(sql);

                   

                       showDialog( context: context,
                         builder: (context) {
                           return AlertDialog(
                             // Retrieve the text that user has entered by using the
                             // TextEditingController.
                             content: Text("  sql =   $sql response $response"),
                           );
                         },
                       );
                     },
                     color:const Color(0xFFB9F6CA),
                     height: 30,
                     textColor:const Color(0xFFFF6F00),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(
                         32.0,
                       ),
                     ),
                     child: const Text('تحيين المعلومات'),
          ),
  ///****************************************/
       ],
      ) ,
  ///*********************ElevatedButton*********************************************/

     ElevatedButton(
       child:  const Text('الرجوع الى الصفحة الرئيسية'),
       onPressed: () {
         Navigator.push(
             context,
             MaterialPageRoute(builder: (context) =>  const CheckenRun()),
         );
       },
     ),


///******************************************************************/



   ],
    ) ,
 ) ,
                    );
  }  
}

