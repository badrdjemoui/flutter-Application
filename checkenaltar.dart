import 'package:chicken/listcheckenaltar.dart';
import 'package:flutter/material.dart';


import 'sqldb.dart';
import 'main.dart';


class Checkenaltar extends StatelessWidget {
  const Checkenaltar({super.key});



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Retrieve Text Input',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: const MyCustomCheckenaltar(),
    );
  }
}


class MyCustomCheckenaltar extends StatefulWidget {
  const MyCustomCheckenaltar({super.key});

  @override
  State<MyCustomCheckenaltar> createState() => _MyCustomCheckenaltar();
}


class _MyCustomCheckenaltar extends State<MyCustomCheckenaltar> {

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
    myController8.text='0.0';
     myController3.text="${DateTime.now().subtract(const Duration(days:1)).day}/${DateTime.now().subtract(const Duration(days:1)).month}/${DateTime.now().subtract(const Duration(days:1)).year}";
                 
  }

  ///*********************************************************** */
   String dropdownvalue1 = 'مينو';

  // List of items in our dropdown menu
  var items1 = [
    'مينو',
    'سوفي حداد',
    'لحمودي',


  ];

///**************
///*************************************************************************** */
/// ///*********************************************************** */
  String dropdownvalue2 = 'رمزي';

  // List of items in our dropdown menu
  var items2 = [
    'رمزي',
    'مذبح 1',
    'مذبح 2',


  ];

///*************************************************************************** */
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
///********************/SingleChildScrollView****************/
 SingleChildScrollView(child:
      Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   mainAxisSize: MainAxisSize.min,
   children: <Widget>[
/************************************/
               TextFormField(
                   controller: myController1,
                   textAlign: TextAlign.center,
                   decoration: const InputDecoration(
                     border: UnderlineInputBorder(),
                     hintText: ' اسم المربي ',
                   )
               ),
/************************************/
      SizedBox(
        height: 50,
        child:DropdownButton(

                 // Initial Value
                 value: dropdownvalue1,

                 // Down Arrow Icon
                 icon: const Icon(Icons.keyboard_arrow_down),

                 // Array list of items
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


/************************************/
               TextFormField(
                   controller: myController2,
                   textAlign: TextAlign.center,
                   decoration: const InputDecoration(
                     border: UnderlineInputBorder(),
                     hintText: ' اسم صاحب المذبح ',
                   )
               ),
/************************************/
      SizedBox(
        height: 50,
        child:DropdownButton(

                 // Initial Value
                 value: dropdownvalue2,

                 // Down Arrow Icon
                 icon: const Icon(Icons.keyboard_arrow_down),

                 // Array list of items
                 items: items2.map((String items) {

                      return DropdownMenuItem(
                     value: items,
                     child: Text(items),
                   );
                 }).toList(),

                 onChanged: (String? newValue) {


                      setState(() {

                    dropdownvalue2 = newValue!;
                     myController2.text=dropdownvalue2.toString();
                   });
                 },

               ),
      ),

/************************************/
      TextFormField(
        controller: myController3,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: ' التاريخ ',
        ),
      ),
     /****************************************/
      TextFormField(
       controller: myController4,
          textAlign: TextAlign.center,
   keyboardType: TextInputType.number,
         decoration: const InputDecoration(
           border: UnderlineInputBorder(),
           hintText: ' العدد الكلي للدجاج',

           )
         ),
     /****************************************/
    TextFormField(
        controller: myController5,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
    decoration: const InputDecoration(
    border: UnderlineInputBorder(),
      hintText: 'سعر الوحدة',
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

     ///**************************************** /row ********************************************************************************/
            
       Row(
        children: <Widget>[

  ///************************************************** /Button ************************/
   
   MaterialButton(

        onPressed:()
              async {
 double costAllAlter = double.parse(myController4.text)*double.parse(myController5.text);



          
       String sql= "INSERT INTO checkenaltar(breeder,nomaltar,date,nbr,unityprice,some,vers) VALUES ('${myController1.text}','${myController2.text}','${myController3.text}','${myController4.text}','${myController5.text}','$costAllAlter','${myController8.text}')";

                print('insert sql  befor ======  $sql'
                );
     int response = await sqlDb.insertData(sql);
                print('response  =======  $response'
                );

       print('myController after =  $response ${myController1.text} ${myController2.text}  ${myController3.text}  ${myController4.text}  ${myController5.text}' );



        showDialog( context: context,
                    builder: (context) {
                       return AlertDialog(
                      
                        content: Text("  checkenaltar =   $sql"),
                                         );
                                     },
                             );
                  },
                 color:const Color(0xFFB9F6CA),
                 height: 30,
                 textColor:const Color(0xFFFF6F00),

                                                    child: const Text('حساب وحفظ'),
               

               ),

          ///****************** /VerticalDivider **********************/
          const VerticalDivider(
           // color: Colors.black,
            thickness: 400,
          ),
          ///****************** VerticalDivider/ **********************/
          
          /**************** /Button ************************/
          MaterialButton(

            onPressed:()
            async {

              String sql= "SELECT * from 'checkenaltar'";

             List<Map> response = await sqlDb.readData(sql);

              print('data $response');

              showDialog( context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text that user has entered by using the
                    // TextEditingController.
                    content: Text("  checkenaltar =   $response"),
                  );
                },
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>   const Mylistcheckenaltar()),
              );
            },
            color:const Color(0xFFB9F6CA),
            height: 30,
            textColor:const Color(0xFFFF6F00),

            child: const Text(' عرض جميع المذبوحات'),
            //shape: ,

          ),
       
         ///*********** /Button ************************/

         
        ],
      ) ,
      /****************  row/ ************************/

     ///**************** /row ************************/
               Row(
                 children: <Widget>[

                   /**************** /Button ************************/
                   MaterialButton(

                     onPressed:()
                     async {

                       String sql= "DELETE from 'checkenaltar' WHERE id = ${myController7.text}";

                       List<Map> response = await sqlDb.deleteData(sql);

                       print('data $response');

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

    ///****************** button/ **********************/
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


                   /**************** /Button ************************/
                   MaterialButton(

                     onPressed:()
                     async {
                       double costpusrch = double.parse(myController4.text)*(double.parse(myController5.text)-double.parse(myController6.text));
                          String sql= "UPDATE 'purchses' SET 'nom' = '${myController1.text}','date' ='${myController2.text}','nbr' ='${myController3.text}','onekg' ='${myController4.text}','poid' ='${myController5.text}','some' ='$costpusrch' WHERE id = ${myController7.text}";

                       int response = await sqlDb.updateData(sql);

                       print('data $response');

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


                  ///********************Button/********************/
                 ],
               ) ,
     ///****************************row/**************************************/
///********************/Button********************/
     ElevatedButton(
       child:  const Text('الرجوع الى الصفحة الرئيسية'),
       onPressed: () {
         Navigator.push(
             context,
             MaterialPageRoute(builder: (context) =>  const CheckenRun()),
         );
       },
     ),

///********************Button/********************/




   ],
    ) ,
 ) ,
  /*
   ) ,

    ) ,
    */






                    );

  }



  
}

