import 'package:flutter/material.dart';
import 'listsales.dart';
import 'sqldb.dart';
import 'sales.dart';
import 'purchases.dart';


void main() => runApp( CheckenRun());

class CheckenRun extends StatelessWidget {
  CheckenRun({super.key});



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
  _MyCustomForState createState() => _MyCustomForState();
}

// Define a corresponding State class. This class holds the data related to the Form.
class _MyCustomForState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value of the TextField.
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

  // double cost =0.0;
  //String sale="";
  SqlDb sqlDb =  SqlDb();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();


    super.dispose();
  }
  String dropdownvalue = 'مينو';

  // List of items in our dropdown menu
  var items = [
    'مينو',
    'سليم',

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        AppBar(title: const Center(
            child: Text(" مينو للحوم البيضاء", style: TextStyle(
              // color:Color.fromRGBO(20, 200, 240, 20),
                color: Colors.blueAccent,
                //   color: Color(0xff3400db),
                fontSize: 22.2,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.white60)
            )
        )
        ),
        body:
    Center(
    child: SingleChildScrollView(child:
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              /******************************************************************/

              ElevatedButton(
                child: Text(' المبيعات', style: TextStyle(
                  // color:Color.fromRGBO(20, 200, 240, 20),
                    color: Colors.blueAccent,
                    //   color: Color(0xff3400db),
                    fontSize: 22.2,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white60)),
                onPressed: () {

    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  Sales()),
    );

                },
              ),


              /******************************************************************/

              /******************************************************************/

              ElevatedButton(
                child: Text(' المشتريات', style: TextStyle(
                  // color:Color.fromRGBO(20, 200, 240, 20),
                    color: Colors.blueAccent,
                    //   color: Color(0xff3400db),
                    fontSize: 22.2,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white60)),
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Purchases()),
                  );

                },
              ),


              /******************************************************************/
            ]
        )
    )
    )
    );
  }
}
