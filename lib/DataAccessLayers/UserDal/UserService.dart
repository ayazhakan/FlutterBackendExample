import 'dart:convert';

import 'package:backend_with_flutter_example/Model/UserModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = 'https://64dbe740593f57e435b18511.mockapi.io/';

Future<List<User>> getUsers() async {
  final response = await http.get(Uri.parse('$baseUrl/user'));

    if(response.statusCode==200){
final userResponse = jsonDecode(response.body);
return userResponse.map<User>((e)=> User.fromMap(e)).toList();
    }
    else {
      throw Exception('Users can not be recieved');
    }

}

}

final userServiceProvider = Provider((ref) {
  return UserService();
});