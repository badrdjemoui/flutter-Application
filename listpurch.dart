import 'package:flutter/material.dart';

import 'main.dart';
import 'sqldb.dart';





class ListPurch extends StatelessWidget {
  const ListPurch({super.key});



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Retrieve Text Input',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: const Mylistpage(),
    );
  }
}

// Define a custom Form widget.
class Mylistpage extends StatefulWidget {
  const Mylistpage({super.key});

  @override
  State<Mylistpage> createState() => _MylistpageState();
}

// Define a corresponding State class. This class holds the data related to the Form.
class _MylistpageState extends State<Mylistpage> {
  double d =0.0;
 SqlDb sqlDb =  SqlDb();

  Future<List<Map>> readDatal() async{
    List<Map> response = await sqlDb.readData("SELECT * FROM purchases") ;
    return response;
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
                child:  const Text('الرجوع الى الصفحة الرئيسية',style:TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 22.2,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white60),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const CheckenRun()),
                  );
                },
              ),


              /******************************************************************/

              FutureBuilder(
                  future: readDatal(),
                  builder:
                      (BuildContext context,AsyncSnapshot<List<Map>> snapshot)
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


                        print(d.toString());
                        return Card(
                          child: ListTile(
                           title:Text("${snapshot.data![i]['id']}  =  ${snapshot.data![i]['nom']}  ${snapshot.data![i]['date']}  ${snapshot.data![i]['nbr']}  ${snapshot.data![i]['poid']}  ${snapshot.data![i]['onekg']}  ${snapshot.data![i]['some']}  ${snapshot.data![i]['vers']}",textDirection: TextDirection.rtl) ,

                                         ),
                               );

                  }
                  )
                  );
                }
                return const Center(child:CircularProgressIndicator());
              }
              ),
              /************************************************************/
              ElevatedButton(
                child:  const Text("مجموع دفعات اليوم",style:TextStyle(
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
                          child:Text(" المجمــــوع اليومـــــي =$d دج ",textDirection:TextDirection.rtl,style:const TextStyle(
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
                child:  const Text(" حـــذف قاعـــدة البيانــــات",style:TextStyle(
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