import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/stateModel.dart';
import 'package:firebase_app/city_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:AppLocalizations.of(context)?.apptitle ?? "" ,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  CollectionReference collectionReference=FirebaseFirestore.instance.collection('India').doc('states').collection('state');
  final TextEditingController _Idontroller=TextEditingController();
  final TextEditingController _cityController=TextEditingController();
  String _id="";
  List<StatetModel> listData=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.apptitle),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _Idontroller,
                        decoration: const InputDecoration(
                          labelText:"State id",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder()
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(
                        labelText: "State",
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder()
                      ),
                    ),
                    ]
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: (){
                  
                  if (_Idontroller.text.isNotEmpty && _cityController.text.isNotEmpty) {
                    uploadingData(_Idontroller.text,_cityController.text);
                    _getAll();
                    _Idontroller.text="";
                    _cityController.text="";
                  }
        
                  else{
                   const snackBar= SnackBar(
                      content: Text("Plese Enter state "),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
        
                },
                child:  Text("${AppLocalizations.of(context)?.add_state}"),
            ),
            Center(
                child: FutureBuilder(
                  future: _getAll(),
                  builder: ( context, AsyncSnapshot<List<StatetModel>> snapshot) {
              
                    if (snapshot.hasData) {
                      debugPrint("data 123 => ${snapshot.data!.length.toString()}");

              
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context,int index){

        
                          // id=snapshot.data![index].id.toString();
                          return GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: ListTile(
                                  title: Text("${AppLocalizations.of(context)?.state_id} = ${snapshot.data?[index].id}"),
                                  subtitle: Text("${AppLocalizations.of(context)?.state} = ${snapshot.data?[index].state}",style: const TextStyle(fontSize: 17),),
                                ),
                              ),
                            ),
                            onTap: (){
                              _id=snapshot.data![index].id!;
                              debugPrint("ID == > $_id");
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyCity(id: _id)));
                            }
                          );
        
                          });
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
          ],
        ),
      )
    );
  }

  Future<void> uploadingData(String id,String state) async {

    StatetModel SatetModel=StatetModel(id , state);

    await FirebaseFirestore.instance.collection('India').doc('states')
        .collection("state").add(SatetModel.toJson());

    debugPrintStack(label: "abc0 $state");
  }


  Future<List<StatetModel>> _getAll() async {

    QuerySnapshot querySnapshot=await collectionReference.get();


    List<StatetModel> list = querySnapshot.docs.map((item) {
      return StatetModel.fromJson(item );
    }).toList();

    debugPrint("abc0 => ${list.toString()}");
    return list;
  }
}
