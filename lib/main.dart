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
  }
// users List<dynamic> || List<Map> [{'id':0}, {'name':''}, {}]
//  users[0]['name'] users[1]['id']
// users List<User>  [User, User, User]
// users[0].id  users[0].name

  @override
  void initState() {
    // TODO: implement initState
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
          title: Text('Dynamic Data'),
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
