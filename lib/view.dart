import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class view extends StatefulWidget {
  const view({Key? key}) : super(key: key);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {

  List value=[];

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    DatabaseReference starCountRef =
    FirebaseDatabase.instance.ref("moradiya");
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      Map m=data as Map;

      value=m.values.toList();

      setState(() {
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("view"),),
    body: GridView.builder(itemCount: value.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          crossAxisSpacing: 2,mainAxisSpacing: 2), itemBuilder: (context, index) {
      return Container(decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.black),borderRadius: BorderRadius.circular(5)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
          Text("${value[index]['name']}"),
          IconButton(onPressed: () {
            showDialog(context: context, builder: (context) {
              return AlertDialog(

              title: Text("Delete Category ${value[index]['name']}"),actions: [
                    TextButton(onPressed: () {
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return view();
                        },));
                      });
                    }, child: Text("No")),

                    TextButton(onPressed: () {
                      DatabaseReference ref = FirebaseDatabase.instance.ref("moradiya").child(value[index]);
                      ref.remove();
                      setState(() {
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return view();
                      },));

                    }, child: Text("Yes")),]

              );
            },);
          }, icon: Icon(Icons.delete))
          // InkWell(onTap: () {
          //   showDialog(context: context, builder: (context) {
          //     return
          //   },);
          // },)

        ]),
      );
    },)
    /*  body: ListView.builder(itemCount: value.length,itemBuilder: (context, index) {
        return ListTile(leading:
        InkWell(onTap: () {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text("Delete Category ${value[index]['name']}"),
              actions: [
                TextButton(onPressed: () {
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return view();
                    },));
                  });
                }, child: Text("No")),

              TextButton(onPressed: () {
                DatabaseReference ref = FirebaseDatabase.instance.ref("moradiya").child(value[index]);
                ref.remove();
                setState(() {
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return view();
                },));

              }, child: Text("Yes")),

            ],
            );
          },

          );

        },child: Icon(Icons.delete_forever_outlined)),
          title: Text("${value[index]['name']}"),
        );
      },),
      */


    );
  }
}
