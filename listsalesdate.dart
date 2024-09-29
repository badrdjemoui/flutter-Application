import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'sales.dart';
import 'main.dart';
import 'sqldb.dart';
import 'main.dart';




class ListSalesDate extends StatelessWidget {
  ListSalesDate({super.key});



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Retrieve Text Input',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: MylistpageD(),
    );
  }
}

// Define a custom Form widget.
class MylistpageD extends StatefulWidget {
  const MylistpageD({super.key});

  @override
  State<MylistpageD> createState() => _MylistpageState();
}

// Define a corresponding State class. This class holds the data related to the Form.
class _MylistpageState extends State<MylistpageD> {
  double d =0.0;
 SqlDb sqlDb =  SqlDb();
  final myController1 = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();

    super.dispose();
  }
  Future<List<Map>> readDatal() async{

    List<Map> response = await sqlDb.readData("SELECT * FROM sales WHERE date LIKE '%"+myController1.toString()+"%'") ;
    print(response.toString());
    return response;
                                     }

  @override
  void initState() {
    super.initState();
    myController1.text=DateTime.now().subtract(Duration(days:1)).day.toString()+"/"+DateTime.now().subtract(Duration(days:1)).month.toString()+"/"+DateTime.now().subtract(Duration(days:1)).year.toString();

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
        body:Container(
          child:

          ListView(
            scrollDirection: Axis.vertical,
            children: [

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

              /****************************************/
      /************************************************************/





      /************************************************************/
              TextFormField(

                  controller: myController1,
                  textAlign: TextAlign.center,
                 // keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'ادخل التاريخ',
                  )
              ),
              /****************************************/
              /******************************************************************/


              /************************************************************/
              ElevatedButton(
                child:  Text("حسب التاريخ",style:TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 22.2,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white60),
                ),
                onPressed: () async{
                  FutureBuilder(

                      future: readDatal(),
                      builder:
                          (BuildContext context,AsyncSnapshot<List<Map>> snapshot)
                      {
                        if (snapshot.hasData) {
                          return Container(
                              height: 400,
                              child:  ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data!.length,
                                  // shrinkWrap: true,
                                  itemBuilder: (context,i){
                                    if (snapshot.data![i]['date']==myController1.toString() ){
                                      d=d+double.parse(snapshot.data![i]['vers'].toString());
                                      return Card(
                                        child: ListTile(
                                          title:Text("${snapshot.data![i]['id']}"+"  =  "+"${snapshot.data![i]['nom']}"+"  "+"${snapshot.data![i]['date']}"+"  "+"${snapshot.data![i]['nbr']}"+"  "+"${snapshot.data![i]['poid']}"+"  "+"${snapshot.data![i]['onekg']}"+"  "+"${snapshot.data![i]['some']}"+"  "+"${snapshot.data![i]['vers']}",textDirection: TextDirection.rtl) ,

                                        ),

                                      );
                                    }


                                  }
                              )
                          );
                        }
                        return Center(child:CircularProgressIndicator());
                      }
                  );

                },
              ),


              /************************************************************/




      /************************************************************/
              ElevatedButton(
                child:  Text("مجموع دفعات اليوم",style:TextStyle(
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
                          child:Text(" المجمــــوع اليومـــــي ="+d.toString()+" دج ",textDirection:TextDirection.rtl,style:TextStyle(
                          fontSize: 18.2,
                          fontWeight: FontWeight.normal,
                         color: Colors.black
                          ),
                      )));

                    },
                  );

                },
              ),


              /************************************************************/
              ElevatedButton(
                child:  Text(" حـــذف قاعـــدة البيانــــات",style:TextStyle(
                // color:Color.fromRGBO(20, 200, 240, 20),
                  color: Colors.blueAccent,
                  //   color: Color(0xff3400db),
                  fontSize: 22.2,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.white60),
              ),
                onPressed: () async{
                  await sqlDb.mydeletedatabase();

                },
              ),



            ],
              ),

        )

    );
  }
}