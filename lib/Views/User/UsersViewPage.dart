import 'package:backend_with_flutter_example/Controllers/UserDal/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Model/UserModel.dart';
import 'UserForm.dart';

class UsersViewPage extends ConsumerWidget{

  const UsersViewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userRepository=ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32.0, horizontal: 32.0),
                    child: Hero(
                        tag: 'user',
                        child: Material(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            color: Colors.grey.shade300,
                            child: Text(
                                "${userRepository.users.length} User"),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: RefreshIndicator(
                onRefresh:
                    () async {
                  ref.refresh(userListProvider);
                },
                child: ref.watch(userListProvider).when(
                  data: (data) => ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) =>
                        UserRow(data[index]),
                    itemCount: data.length,
                  ),
                  error: (error, stackTrace) {
                    return const SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Text('error'),
                    );


                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.of(context)
              .push(MaterialPageRoute<bool>(builder: (context) {
            return UserForm();
          }));
          if (created == true) {
            print("refresh the users");
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserRow extends StatelessWidget{
  final User user;

  const UserRow(this.user, {super.key});


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${user.name}"),
      leading: CircleAvatar(child: CircleAvatar(backgroundImage: NetworkImage("${user.avatar}")),)
    );
  }
}
