import 'package:http/http.dart' as http;
//from pub.dev in the pubspec.yaml for dealing with any http(s) calls
// http.get, http.post
import 'dart:convert';
//for JSON conversion
import 'dart:async';
//for Futures (Promises)

class HttpHelper {
  //A place to put all / any of our fetch calls

  static Future<List<User>> fetch(String url, String method) async {
    Uri uri = Uri.parse(url);
    //convert the url String into a Uri object.

    switch (method) {
      case 'get':
        http.Response resp = await http.get(uri);
        if (resp.statusCode == 200) {
          //we got our response
          List<dynamic> data = jsonDecode(resp.body) as List<dynamic>;
          //we want List<User>
          return data.map((user) {
            return User.fromJson(user);
          }).toList(); //data.map() returns an Iterable, we need a List.
        } else {
          throw Exception('Did not get a valid response.');
        }
      case 'post':
        http.Response resp = await http.post(uri,
            body: jsonEncode({'name': 'Buddy', 'email': 'pal@friend.org'}),
            headers: {'Content-type': 'application/json; charset=UTF-8'});
        if (resp.statusCode == 201) {
          Map<String, dynamic> data = jsonDecode(resp.body);
          User user = User.fromJson(data);
          return [user];
        } else {
          throw Exception('Did not get a valid response.');
        }
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
    int id = userdata['id'];
    String name = userdata['name'];
    String email = userdata['email'];
    return User(id: id, name: name, email: email);
  }
}
