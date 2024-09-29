import 'package:chicken/listsalesdate.dart';
import 'package:flutter/material.dart';
import 'sqldb.dart';
import 'main.dart';
import 'listsales.dart';


class Sales extends StatelessWidget {
  Sales({super.key});



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Retrieve Text Input',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: MyCustomFor(),
    );
  }
}

// Define a custom Form widget.
class MyCustomFor extends StatefulWidget {
  const MyCustomFor({super.key});

  @override
  State<MyCustomFor> createState() => _MyCustomFormStat();
}

// Define a corresponding State class. This class holds the data related to the Form.
class _MyCustomFormStat extends State<MyCustomFor> {
  // Create a text controller and use it to retrieve the current value of the TextField.
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
  String dropdownvalue1 = 'مينو';

  // List of items in our dropdown menu
  var items1 = [
    'مينو',
    'سليم',
    'غاني',
    'هاني',
    'خيرو',
    'بلال',
    'حمزة',
    'الحاج',
    'مينو القص',

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

 SingleChildScrollView(child:
      Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.center,
   mainAxisSize: MainAxisSize.min,
   children: <Widget>[

               TextFormField(
                   controller: myController1,
                  // keyboardType: TextInputType.number,
                  // maxLength: 5,

                   textAlign: TextAlign.center,

                  // autofocus: true,
                  // initialValue:'',
                   decoration: InputDecoration(
                     hintText: 'اسم الزبون',
                    // counterText: "",
                    // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                     //vbvbvbborder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),

                 // textAlign: TextAlign.center,
                   //controller: myController1,
                // decoration:  InputDecoration(
                 //  border: UnderlineInputBorder(),


                 //    labelText:' اسم الزبون ',

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
                   myController8.text=DateTime.now().subtract(Duration(days:1)).day.toString()+"/"+DateTime.now().subtract(Duration(days:1)).month.toString()+"/"+DateTime.now().subtract(Duration(days:1)).year.toString();
                   myController6.text='0.0';
                   return DropdownMenuItem(
                     value: items,
                     child: Text(items),
                   );
                 }).toList(),
                 // After selecting the desired option,it will
                 // change button value to selected value
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
        decoration: InputDecoration(
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
           hintText: ' العدد ',

           )
         ),
     /****************************************/
    TextFormField(
        controller: myController4,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
    decoration: const InputDecoration(
    border: UnderlineInputBorder(),
      hintText: 'الوزن الكلي',
    )
    ),
               /****************************************/
               TextFormField(
        controller: myController5,
                   textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
    decoration: const InputDecoration(
    border: UnderlineInputBorder(),
      hintText: 'سعر الكلغ ',
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
           hintText: 'دفع',
         )
     ),
     /****************************************/
               /**************** /row ************************/
       Row(

        children: <Widget>[
          /**************** /Button ************************/
          new Expanded (
            flex:1,
            child :

            MaterialButton(

        onPressed:()
              async {
 double cost = double.parse(myController4.text)*double.parse(myController5.text);


                print('myController before =  '+
                    //response.toString()
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
       String sql= "INSERT INTO "+"sales"+"(nom,date,nbr,poid,onekg,some,vers)"+" VALUES "+
           "('"+myController1.text+"','"+myController2.text+"','"+myController3.text+"','"+myController4.text+"','"+myController5.text+"','"+
           cost.toString()+"','"+myController6.text+"')";

                print('sql befor =  '+
                    sql
                );
     int response = await sqlDb.insertData(sql);
                print('sql after  =  '+
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
                        content: Text("  sale =   "+sql),
                                         );
                                     },
                             );
                  },

               child: Text('حساب وحفظ',textAlign: TextAlign.center,),
                 color:Color(0xFFB9F6CA),
                 height: 30,
                 textColor:Color(0xFFFF6F00),
                 //shape: ,

            ),
          ),
          /****************** button/ **********************/
          VerticalDivider(
           // color: Colors.black,
            thickness: 400,
          ),
          /**************** /Button ************************/
          new Expanded (
            flex:2,
            child :
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
                MaterialPageRoute(builder: (context) =>   ListSales()),
              );
            },

            child: Text('عرض جميع المبيعات',textAlign: TextAlign.center,),
            color:Color(0xFFB9F6CA),
            height: 30,
            textColor:Color(0xFFFF6F00),
            //shape: ,

            ),
          ),
          /****************** button/ **********************/
          VerticalDivider(
            // color: Colors.black,
            thickness: 400,
          ),
          /**************** /Button ************************/
            new Expanded (
              flex:2,
              child :
              MaterialButton(

            onPressed:()
            async {

              String sql= "SELECT * from 'sales' where date ="+myController2.text;;

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
                MaterialPageRoute(builder: (context) =>   ListSalesDate()),
              );
            },

            child: Text('عرض المبيعات حسب التاريخ',textAlign: TextAlign.center,),
            color:Color(0xFFB9F6CA),
            height: 30,
            textColor:Color(0xFFFF6F00),
            //shape: ,

              ),
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

                       String sql= "DELETE from 'sales' WHERE id = "+myController7.text;

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
                       double cost = double.parse(myController4.text)*double.parse(myController5.text);
                       String sale =myController1.text+" I "+myController2.text+" I "+myController3.text+" I "+myController4.text+" I "+myController5.text+" I "+cost.toString();
                       String sql= "UPDATE 'sales' SET 'txt' = '"+sale.toString()+"' WHERE id = "+myController7.text;

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

