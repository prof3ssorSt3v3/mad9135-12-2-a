import 'package:flutter/material.dart';
import 'package:fetch/utils/http_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<List<User>> users =
      HttpHelper.fetch('https://jsonplaceholder.typicode.com/users', 'get');
  //State variable now holds a Future and calls the fetch method immediately

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic Data'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<List<User>>(
            future: users,
            builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
              if (snapshot.hasData) {
                //build the listview
                return const Center(child: FlutterLogo(size: 100));
              } else if (snapshot.hasError) {
                //tell the user you don't like them
                return const Center(child: FlutterLogo(size: 40));
              } else {
                //tell them to wait...
                return const Center(child: Text('No Data Dude.'));
              }
            },
          ),
        ),
      ),
    );
  }
}

/*
ListView.builder(
  itemCount: snapshot.data.length,
  itemBuilder: (BuildContext context, int index) {
    User user = snapshot.data[index];
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
    );
  },
)
*/