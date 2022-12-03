import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('beklenilmeyen bir hata olustu'));
          } else if (snapshot.hasData) {
            return MyHomePage();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference moviesRef = _firestore.collection('movies');
    var babaRef = moviesRef.doc('Baba');
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Firestore CRUD işlemleri'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text(
                '${babaRef.get()}',
                style: TextStyle(fontSize: 24),
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                  onPressed: () async {
                    var response = await babaRef.get();
                    // documentSnapshot nedir ??
                    // documentsnapshot icinden cıkarmak lazım
                    //dynamic map = response.data();
                    // print(map['name']);
                  },
                  child: Text(
                    'get data',
                    style: TextStyle(color: Colors.black54),
                  )),
              StreamBuilder<QuerySnapshot>(
                // neyi dinlediğimiz bilgisi hangi streami
                stream: moviesRef.snapshots(),
                // her yeni aktıgında asadıkaını built et

                builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    return Center(
                      child: Text('haat'),
                    );
                  } else {
                    if (asyncSnapshot.hasData) {
                      List<DocumentSnapshot> listofsnaps =
                          asyncSnapshot.data.docs;

                      return Flexible(
                        child: ListView.builder(
                            itemCount: listofsnaps.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                tileColor: Colors.purple,
                                title: Text('${listofsnaps[index].data()}'),
                                //subtitle: Text('${listofsnaps[index].data()}'),
                              );
                            }),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
