import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/cityModel.dart';
import 'package:flutter/material.dart';

// class City_State extends StatelessWidget{
//   const City_State({super.key,required this.id});
//
//   final String id;
//
//   @override
//   Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Citys',
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//        useMaterial3: true,
//      ),
//      home: const MyCity(title: 'Citys '),
//    );
//   }
//
// }

class MyCity extends StatefulWidget{
  const MyCity({super.key,required this.id});
  final String id;


  @override
  State<StatefulWidget> createState() =>_CityScreen();

}

class _CityScreen extends State<MyCity>{
  List<String> cityNames = [];

  CollectionReference collectionReference=FirebaseFirestore.instance.collection('state');

  @override
  Widget build(BuildContext context) {
    print("state_id 123 =>${widget.id}");
   return Scaffold(
     appBar: AppBar(
       title: Text("city"),
       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
     ),
     body: Padding(
       padding: const EdgeInsets.all(8.0),
       child: SingleChildScrollView(
         child: Center(
           child: FutureBuilder(
             future: _getAll(),
             builder: ( context, AsyncSnapshot<List<CityModel>> snapshot) {
               print("snapshot = ${snapshot.data?.length}");
               if (snapshot.hasData) {
                 getCityNames(snapshot: snapshot);
                 print("city length= ${cityNames.length}");
                 return ListView.builder(
                     itemCount: cityNames.length,
                     shrinkWrap: true,
                     itemBuilder: (context,index){
                       return Column(
                         children: [
                           Card(
                             child: ListTile(
                               title: Text("${cityNames[index]}"),
                             ),
                           )
                         ],
                       );
                     });
               }
               else{
                 return const Center( child: CircularProgressIndicator(),);
               }
               },
           ),
         ),
       ),
     ),
   );
  }
  Future<List<CityModel>> _getAll() async {
    QuerySnapshot querySnapshot = await collectionReference.get();
    List<CityModel> list = querySnapshot.docs.map((item) {
      return CityModel.fromJson(item);
    }).toList();
    print("abc123 => ${list.toString()}");
    return list;
  }

  void getCityNames({required AsyncSnapshot<List<CityModel>> snapshot}) {
    for(int i = 0 ; i < snapshot.data!.length ; i++)  {
      if(snapshot.data![i].state_id==widget.id) {
        print('object2 =  ${snapshot.data![i].city}');
        cityNames.add(snapshot.data![i].city);
        print('object = ${cityNames.length}');
      }
      else {
        print('object1');
      }
    }
  }
}