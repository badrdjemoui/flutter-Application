import 'package:chicken/listsalesdate.dart';
import 'package:chicken/salespdf.dart';
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
      home:  MyCustomFor(),
    );
  }
}

// Define a custom Form widget.
class MyCustomFor extends StatefulWidget {
   MyCustomFor({super.key});
final PdfGenerator pdfGenerator = PdfGenerator();
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
   ///************************initState*********************************** */

 @override
  void initState() {
    super.initState();
    myController2.text="${DateTime.now().subtract(const Duration(days:1)).day}/${DateTime.now().subtract(const Duration(days:1)).month}/${DateTime.now().subtract(const Duration(days:1)).year}";
    myController8.text="${DateTime.now().subtract(const Duration(days:1)).day}/${DateTime.now().subtract(const Duration(days:1)).month}/${DateTime.now().subtract(const Duration(days:1)).year}";
    myController6.text='0.0';            
  }

  ///*********************************************************** */
  String dropdownvalue1 = 'مينو';

  var items1 = [
    'مينو',
    'سليم',
    'غاني',
    'هاني',
    'خيرو',
    'بلال',
    'حمزة',
    'الحاج',
   

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

///*****************SingleChildScrollView*******************/

 SingleChildScrollView(child:
      Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.center,
   mainAxisSize: MainAxisSize.min,
   children: <Widget>[

///*****************TextFormField*******************/

               TextFormField(
                   controller: myController1,
                   textAlign: TextAlign.center,
                   decoration: const InputDecoration(
                     hintText: 'اسم الزبون', 
                  //   labelText: 'اسم الزبون',               
                   )
               ),

///***************SizedBox*********************/
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

///************************************/
      TextFormField(
        controller: myController2,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: ' التاريخ ',
        ),
      ),
///****************************************/
      TextFormField(
       controller: myController3,
          textAlign: TextAlign.center,
   keyboardType: TextInputType.number,
         decoration: const InputDecoration(
           border: UnderlineInputBorder(),
          // labelText: 'العدد',  
           hintText: ' العدد ',

           )
         ),
///****************************************/
    TextFormField(
        controller: myController4,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
    decoration: const InputDecoration(
    border: UnderlineInputBorder(),
   // labelText: 'الوزن الكلي',  
      hintText: 'الوزن الكلي',
    )
    ),
///****************************************/
               TextFormField(
        controller: myController5,
                   textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
    decoration: const InputDecoration(
    border: UnderlineInputBorder(),
      hintText: 'سعر الكلغ ',
    )
    ),
///****************************************/
     TextFormField(
         controller: myController6,
         textAlign: TextAlign.center,
         keyboardType: TextInputType.number,
         decoration: const InputDecoration(
           border: UnderlineInputBorder(),
           hintText: 'دفع',
         )
     ),
///****************************************/
///**************** /row ************************/
       Row(

        children: <Widget>[
 ///**************** /Expanded ************************/
          Expanded (
            flex:1,
            child :
 ///**************** /Button ************************/
            MaterialButton(

        onPressed:()
              async {
 double cost = double.parse(myController4.text)*double.parse(myController5.text);


               
       String sql= "INSERT INTO sales(nom,date,nbr,poid,onekg,some,vers) VALUES ('${myController1.text}','${myController2.text}','${myController3.text}','${myController4.text}','${myController5.text}','$cost','${myController6.text}')";

 
              
     


        showDialog( context: context,
                    builder: (context) {
                       return AlertDialog(
                       // Retrieve the text that user has entered by using the
                       // TextEditingController.
                        content: Text("  sale =   $sql"),
                                         );
                                     },
                             );
                  },
                 color:const Color(0xFFB9F6CA),
                 height: 30,
                 textColor:const Color(0xFFFF6F00),

               child: const Text('حساب وحفظ',textAlign: TextAlign.center,),
                 //shape: ,

            ),
          ),

///****************** /VerticalDivider **********************/
          const VerticalDivider(
           // color: Colors.black,
            thickness: 400,
          ),
///**************** /Expanded ************************/
          Expanded (
            flex:2,
            child :
///**************** /MaterialButton ************************/
            MaterialButton(

            onPressed:()
            async {

              String sql= "SELECT * from 'sales'";

             List<Map> response = await sqlDb.readData(sql);

      

              showDialog( context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text that user has entered by using the
                    // TextEditingController.
                    content: Text("  sale =   $response"),
                  );
                },
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>   const ListSales()),
              );
            },
            color:const Color(0xFFB9F6CA),
            height: 30,
            textColor:const Color(0xFFFF6F00),

            child: const Text('عرض جميع المبيعات',textAlign: TextAlign.center,),
            //shape: ,

            ),
          ),
///******************VerticalDivider**********************/
          const VerticalDivider(
            // color: Colors.black,
            thickness: 400,
          ),
///**************** /Expanded ************************/
            Expanded (
              flex:2,
              child :
///**************** /MaterialButton ************************/
              MaterialButton(

            onPressed:()
            async {

              String sql= "SELECT * from 'sales' where date =${myController2.text}";

              List<Map> response = await sqlDb.readData(sql);

          

              showDialog( context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text that user has entered by using the
                    // TextEditingController.
                    content: Text("  sale =   $response"),
                  );
                },
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>   const ListSalesDate()),
              );
            },
            color:const Color(0xFFB9F6CA),
            height: 30,
            textColor:const Color(0xFFFF6F00),

            child: const Text('عرض المبيعات حسب التاريخ',textAlign: TextAlign.center,),
            //shape: ,

              ),
            ),
          /****************** button/ **********************/


          /****************************************/
        ],
      ) ,
  

///**************** /row ************************/
               Row(
                 children: <Widget>[

///**************** /MaterialButton ************************/
                   MaterialButton(

                     onPressed:()
                     async {

                       String sql= "DELETE from 'sales' WHERE id = ${myController7.text}";

                       List<Map> response = await sqlDb.deleteData(sql);

                    

                       showDialog( context: context,
                         builder: (context) {
                           return AlertDialog(
                             // Retrieve the text that user has entered by using the
                             // TextEditingController.
                             content: Text("  sale =   $response"),
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

///****************** SizedBox **********************/
                    SizedBox(
                     width: 100.0,
                     child:
///****************** TextFormField **********************/
                     TextFormField(
                       controller: myController7,
                       keyboardType: TextInputType.number,
                       decoration: const InputDecoration(
                         border: UnderlineInputBorder(),
                         labelText: ' عدد السجل المراد حذفه او تغييره ',

                       )
                     ),
                   ),

/**************** /MaterialButton ************************/
                   MaterialButton(

                     onPressed:()
                     async {
                       double cost = double.parse(myController4.text)*double.parse(myController5.text);
                       String sale ="${myController1.text} I ${myController2.text} I ${myController3.text} I ${myController4.text} I ${myController5.text} I $cost";
                       String sql= "UPDATE 'sales' SET 'txt' = '$sale' WHERE id = ${myController7.text}";

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


                   /****************************************/
                 ],
               ) ,
     /******************************************************************/

     ElevatedButton(
       child:  const Text('الرجوع الى الصفحة الرئيسية'),
       onPressed: () {
         Navigator.push(
             context,
             MaterialPageRoute(builder: (context) =>  const CheckenRun()),
         );
       },
     ),


     /******************************************************************/

       /******************************************************************/

  
     
      ElevatedButton(
          onPressed: () async {
           PdfGenerator pdfGenerator = PdfGenerator();
            await pdfGenerator.writeOnPdf();
            await pdfGenerator.savePdf();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(' طباعة المبيعات علي شكل ملف pdf')),
            );
          },
          child: Text('Create PDF'),
        ),
    

     /******************************************************************/




   ],
    ) ,
 ) ,

   );

  }



  
}

