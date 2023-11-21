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
  List<User> users = [];

  void getInfo() async {
    //get the data from HttpHelper
    List<User> userlist = await HttpHelper.fetch(
        'https://jsonplaceholder.typicode.com/users', 'get');
    //update state with the new value
    setState(() {
      users = userlist;
    });

    //example of calling POST
    // List<User> tempUser = await HttpHelper.fetch(
    //     'https://jsonplaceholder.typicode.com/users', 'post');
    // print(tempUser[0].id.toString() + tempUser[0].name);
  }

  @override
  void initState() {
    super.initState();
    //like the useEffect hook from React
    //don't make it async
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic Data'),
        ),
        body: users.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  User user = users[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  );
                },
              )
            : const Center(child: Text('No Data Dude.')),
      ),
    );
  }
}
