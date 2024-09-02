import 'package:flutter/material.dart';
import 'listpurch.dart';
import 'listsales.dart';
import 'sqldb.dart';
import 'main.dart';


class Purchases extends StatelessWidget {
  Purchases({super.key});



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Retrieve Text Input',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: MyCustomForPur(),
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
  String dropdownvalue1 = 'لحمودي';

  // List of items in our dropdown menu
  var items1 = [
    'مينو',
    'سوفي حداد',
    'لحمودي',


  ];


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
                   decoration: const InputDecoration(
                     border: UnderlineInputBorder(),
                     labelText: ' اسم المربي ',
                   )
               ),
/************************************/
      Container(
        height: 50,
        child:DropdownButton(

                 // Initial Value
                 value: dropdownvalue1,

                 // Down Arrow Icon
                 icon: const Icon(Icons.keyboard_arrow_down),

                 // Array list of items
                 items: items1.map((String items) {

                   myController2.text=DateTime.now().subtract(Duration(days:1)).day.toString()+"/"+DateTime.now().subtract(Duration(days:1)).month.toString()+"/"+DateTime.now().subtract(Duration(days:1)).year.toString();
                   myController6.text='0.0';
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

        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: ' التاريخ ',
        ),
      ),
     /****************************************/
      TextFormField(
       controller: myController3,
   keyboardType: TextInputType.number,
         decoration: const InputDecoration(
           border: UnderlineInputBorder(),
            labelText: ' العدد الكلي للدجاج',

           )
         ),
     /****************************************/
    TextFormField(
        controller: myController4,
        keyboardType: TextInputType.number,
    decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'سعر الكلغ',
    )
    ),
               /****************************************/
               TextFormField(
        controller: myController5,
        keyboardType: TextInputType.number,
    decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'الوزن الكلي ',
    )
    ),
     /****************************************/
     /****************************************/
     TextFormField(
         controller: myController6,
         keyboardType: TextInputType.number,
         decoration: const InputDecoration(
           border: UnderlineInputBorder(),
           labelText: 'الوزن المسترجع',
         )
     ),
     /****************************************/
     TextFormField(
         controller: myController8,
         keyboardType: TextInputType.number,
         decoration: const InputDecoration(
           border: UnderlineInputBorder(),
           labelText: 'دفع',
         )
     ),
     /****************************************/
     /****************************************/
               /**************** /row ************************/
       Row(
        children: <Widget>[
          /**************** /Button ************************/
               MaterialButton(

        onPressed:()
              async {
 double costpurch = double.parse(myController4.text)*(double.parse(myController5.text)-double.parse(myController6.text));



                print('myController before =  '+
                      " myController1=  "+
                    myController1.text
                    +" myController2=   "+
                    myController2.text
                    +"  myController3=  "+
                    myController3.text
                    +" myController4=   "+
                    myController4.text
                    +" myController5=   "+
                    myController5.text
                    +"/ln"
                );
       String sql= "INSERT INTO "+"purchases"+"(nom,date,nbr,onekg,poid,some,vers)"+" VALUES "+
           "('"+myController1.text+"','"+myController2.text+"','"+myController3.text+"','"+myController4.text+"','"+myController5.text+"','"+
           costpurch.toString()+"','"+myController8.text+"')";

                print('sql puchases befor =  '+
                    sql
                );
     int response = await sqlDb.insertData(sql);
                print('sql puchases after  =  '+
                    sql
                );

       print('myController after =  '+
         response.toString()+

           myController1.text
           +
           myController2.text
           +
           myController3.text
           +
           myController4.text
           +
           myController5.text
       );



        showDialog( context: context,
                    builder: (context) {
                       return AlertDialog(
                       // Retrieve the text that user has entered by using the
                       // TextEditingController.
                        content: Text("  purchses =   "+sql),
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

              String sql= "SELECT * from 'purchases'";

             List<Map> response = await sqlDb.readData(sql);

              print('data '+response.toString());

              showDialog( context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text that user has entered by using the
                    // TextEditingController.
                    content: Text("  purchses =   "+response.toString()),
                  );
                },
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>   ListPurch()),
              );
            },

            child: Text(' عرض جميع المشتريات'),
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

                       String sql= "DELETE from 'purchses' WHERE id = "+myController7.text;

                       List<Map> response = await sqlDb.deleteData(sql);

                       print('data '+response.toString());

                       showDialog( context: context,
                         builder: (context) {
                           return AlertDialog(
                             // Retrieve the text that user has entered by using the
                             // TextEditingController.
                             content: Text("  purchses =   "+response.toString()),
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
                          String sql= "UPDATE 'purchses' SET 'nom' = '"+myController1.text+"',"+"'date' ='"+myController2.text+"',"+"'nbr' ='"+myController3.text+"',"+"'onekg' ='"+myController4.text+"',"+"'poid' ='"+myController5.text+"',"+"'some' ='"+costpusrch.toString()+"'"+" WHERE id = "+myController7.text;

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


                   /****************************************/
                 ],
               ) ,
     /******************************************************************/

     ElevatedButton(
       child:  Text('الرجوع الى الصفحة الرئيسية'),
       onPressed: () {
         Navigator.push(
             context,
             MaterialPageRoute(builder: (context) =>  CheckenRun()),
         );
       },
     ),


     /******************************************************************/



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

