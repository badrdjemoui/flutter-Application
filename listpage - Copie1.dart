import 'package:flutter/material.dart';
import 'main.dart';
import 'sqldb.dart';




class Listpage extends StatelessWidget {
  Listpage({super.key});



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Retrieve Text Input',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: Mylistpage(),
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

 SqlDb sqlDb =  SqlDb();

  Future<List<Map>> readData() async{
    List<Map> response = await sqlDb.readData("SELECT * FROM sales") ;
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
              ElevatedButton(
                child:  Text('الرجوع الى الصفحة الرئيسية'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  RunMyApp()),
                  );
                },
              ),


              /******************************************************************/

              FutureBuilder(
                  future: readData(),
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
                        return Card(
                          child: ListTile(
                            title:Text("${snapshot.data![i]['id']}"+"  =  "+"${snapshot.data![i]['txt']}") ,
                                         ),
                               );

                  }
                  )
                  );
                }
                return Center(child:CircularProgressIndicator());
              }
              ),
              /************************************************************/
              ElevatedButton(
                child:  Text('جذف قاعدة البيانات'),
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