import 'package:flutter/material.dart';
import 'main.dart';
import 'sqldb.dart';

///******************************************************************/

class ListSalesDate extends StatelessWidget {
 const  ListSalesDate({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Retrieve Text Input',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: const MylistpageD(),
    );
  }
}

///******************************************************************/


class MylistpageD extends StatefulWidget {
  const MylistpageD({super.key});

  @override
  State<MylistpageD> createState() => _MylistpageState();
}

///******************************************************************/

class _MylistpageState extends State<MylistpageD> {
  double d =0.0;
 SqlDb sqlDb =  SqlDb();
  final myController1 = TextEditingController();
  Future<List<Map>>? readDatall;

  @override
///******************************************************************/
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();

    super.dispose();
  }

///******************************************************************/

showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () async{
      await sqlDb.mydeletedatabase();
      showDialog( context: context,
                    builder: (context) {
                       return AlertDialog(
                        content: Text("data base deleted by succes"),
                                         );
                                     },
                             );
     },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Delete data base"),
    content: const Text("are you sure."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

///************************************************************/

  Future<List<Map>> readDatal() async{


String strurl = "SELECT * FROM sales WHERE date like '%${myController1.text}%'";

    List<Map> response = await sqlDb.readData(strurl) ;



    return response;
         }



///******************************************************************/
  @override
  void initState() {
myController1.text="${DateTime.now().subtract(const Duration(days:1)).day}/${DateTime.now().subtract(const Duration(days:1)).month}/${DateTime.now().subtract(const Duration(days:1)).year}";
d =0.0;
    super.initState();

    
  }
///******************************************************************/
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

          ListView(
            scrollDirection: Axis.vertical,
            children: [


///******************************************************************/

              ElevatedButton(
                child:  const Text('الرجوع الى الصفحة الرئيسية'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const CheckenRun()),
                  );
                },
              ),


///************************************************************/
              TextFormField(

                  controller: myController1,
                  textAlign: TextAlign.center,
                 // keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'ادخل التاريخ',
                  )
              ),
///****************************************/
              
          
              ElevatedButton(
                child:  const Text("حسب التاريخ",style:TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 22.2,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white60),
                ),
                onPressed: () {
                d =0.0;                
              setState(() {

                readDatall=readDatal(); 
              
                            }  ); },
          ),
          
///************************************************************/
                  FutureBuilder(
                      future: readDatall,
                    
                      builder: (BuildContext context,AsyncSnapshot<List<Map>> snapshot)
                      {
                         if (snapshot.hasData) {
                              return SizedBox(
                              height: 400,
                              child:  ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data!.length,
                                  // shrinkWrap: true,
                                  itemBuilder: (context,i){
                                          d=d+double.parse(snapshot.data![i]['vers'].toString());
                                      return Card(
                                        child: ListTile(
                                          title:Text("${snapshot.data![i]['id']}  =  ${snapshot.data![i]['nom']}  ${snapshot.data![i]['date']}  ${snapshot.data![i]['nbr']}  ${snapshot.data![i]['poid']}  ${snapshot.data![i]['onekg']}  ${snapshot.data![i]['some']}  ${snapshot.data![i]['vers']}",textDirection: TextDirection.rtl) ,

                                        ),

                                      );
                                    }
                                        //   else { return const Center(child:CircularProgressIndicator()); }

                                
                                 
                              )
                          );
                        }
                        return const Center(child:CircularProgressIndicator());
                      }
                  ),
    
            

 

///************************************************************/
              ElevatedButton(
                child: const Text("مجموع دفعات اليوم",style:TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 22.2,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white60),
                ),
                onPressed: () async{
                  await
                  showDialog( context: context,
                    builder: (context) {
                      return  Center(child:Container(
                          color: Colors.white,
                          child: Text(" المجمــــوع اليومـــــي =$d دج ",textDirection:TextDirection.rtl,style:const TextStyle(
                          fontSize: 18.2,
                          fontWeight: FontWeight.normal,
                         color: Colors.black
                          ),
                      )
                      )
                      );

                    },
                  );

                },
              ),


///************************************************************/

              ElevatedButton(
                child: const Text(" حـــذف قاعـــدة البيانــــات",style:TextStyle(
                // color:Color.fromRGBO(20, 200, 240, 20),
                  color: Colors.blueAccent,
                  //   color: Color(0xff3400db),
                  fontSize: 22.2,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.white60),
              ),
                onPressed: ()  {
                  showAlertDialog(context);
                  

                },
              ),



            ],
              ),

       

    );
  }
  }