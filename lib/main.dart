import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_data/view.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
 // WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: Home(),debugShowCheckedModeBanner: false,));
      
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Setting"),),
      body: Column(children: [
        Row(children: [
          Text("Category"),
          IconButton(onPressed: () {
            showModalBottomSheet(context: context, builder: (context) {
              return Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
                child: Column(
                  children: [
                    Text("Add New category"),
                    TextField(controller: name,decoration: InputDecoration(labelText: "Enter category"),),
                    
                    TextButton(onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return view();
                      },));
                      DatabaseReference ref =
                      FirebaseDatabase.instance.ref("moradiya").push();
                      await ref.set({
                        "name": "${name.text}"
                      });

                    }, child: Text("+ Add New Category"))
                    
                  ],
                ),
              );
            },);
            
          }, icon: Icon(Icons.add))
        ],),
        IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return view();
          },));
        }, icon: Icon(Icons.done))
      ],),
    );
  }
}
