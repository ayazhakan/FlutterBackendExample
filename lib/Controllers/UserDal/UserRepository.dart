import 'package:backend_with_flutter_example/Controllers/UserDal/UserService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Model/UserModel.dart';



class UserRepository extends ChangeNotifier{



  List<User> users= [];

  final UserService userService;

  UserRepository(this.userService);

  Future<List<User>> getUsers() async {
    users = await userService.getUsers();
    return users;

}

}

final usersProvider=ChangeNotifierProvider((ref){
    return UserRepository(ref.watch(userServiceProvider));
});

final userListProvider= FutureProvider((ref){
return ref.watch(usersProvider).getUsers();
});