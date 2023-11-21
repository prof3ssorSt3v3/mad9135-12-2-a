import 'package:http/http.dart' as http;
//from pub.dev in the pubspec.yaml for dealing with any http(s) calls
// http.get, http.post
import 'dart:convert';
//for JSON conversion
import 'dart:async';
//for Futures (Promises)

class HttpHelper {
  //A place to put all / any of our fetch calls
  //without 'static'
  //HttpHelper hh = HttpHelper();
  //hh.fetch();
  // HttpHelper().fetch()
  // Random().nextInt()
  //with 'static'
  // HttpHelper.fetch()

  static Future<List<User>> fetch(String url, String method) async {
    Uri uri = Uri.parse(url);
    //convert the url String into a Uri object.

    switch (method) {
      case 'get':
        http.Response resp = await http.get(uri);
        if (resp.statusCode == 200) {
          //we got our response
          List<dynamic> data = jsonDecode(resp.body) as List<dynamic>;
          // return data; // List<Map<String, dynamic>>
          //we want List<User>
          // User(id:anum, name:aname, email:anemail)
          return data.map((user) {
            return User.fromJson(user);
            // return User(
            //     id: user['id'], name: user['name'], email: user['email']);
          }).toList(); //data.map() returns an Iterable.
        } else {
          throw Exception('Did not get a valid response.');
        }
      case 'post':
      default:
        throw Exception('Not a valid method.');
    }
  }
}

//Data Models
class User {
  late int id;
  late String name;
  late String email;

  //default constructor
  User({required this.id, required this.name, required this.email});

  //named constructor
  User.fromJson(Map<String, dynamic> userdata) {
    id = userdata['id'] ?? 0;
    name = userdata['name'] ?? 'bob';
    email = userdata['email'] ?? 'bob@home.org';
    //constructors do NOT have return keywords
  }

  factory User.fromData(Map userdata) {
    int _id = userdata['id'];
    String _name = userdata['name'];
    String _email = userdata['email'];
    return User(id: _id, name: _name, email: _email);
  }
}
