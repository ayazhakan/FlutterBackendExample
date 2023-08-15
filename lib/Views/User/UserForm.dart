import 'package:backend_with_flutter_example/Controllers/UserDal/UserService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faker/faker.dart';

import '../../Model/UserModel.dart';

class UserForm extends ConsumerStatefulWidget{


  @override
  ConsumerState<ConsumerStatefulWidget> createState()=> _userFormState();

}

class _userFormState extends ConsumerState<UserForm>{
  final Map<String, dynamic> givenUser = {};
  final _formKey = GlobalKey<FormState>();

  bool isSaving = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New User'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.person,size: 200),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Name"),
                  ),
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return "Name is necessary!";
                    }
                    else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    givenUser['name'] = newValue;
                    String avatar=faker.image.toString();
                    givenUser['avatar'] = avatar;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("City"),
                  ),
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return "City is necessary";
                    }
                    else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    givenUser['City'] = newValue;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Country"),
                  ),
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return "Country is necessary";
                    }
                    else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    givenUser['country'] = newValue;
                  },
                ),TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Address"),
                  ),
                  validator: (value) {
                    if (value?.isNotEmpty != true) {
                      return "Address is necessary";
                    }
                    else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    givenUser['streetAddress'] =newValue;
                  },
                ),
                isSaving
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                    onPressed: () async {
                      final formState = _formKey.currentState;
                      if (formState == null) return;
                      if (formState.validate() == true) {
                        formState.save();
                        print(givenUser);
                      }
                      _save();
                    },
                    child: const Text("Save"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void>_save()async{
    bool ended=false;
    while(!ended){
      try{
        setState((){
            isSaving=true;
        });
        await saveAll();
        ended=true;
        Navigator.of(context).pop(true);
      }
      catch(e){
        final snackBar = ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
        await snackBar.closed;

      }
      finally{
        setState(() {
          isSaving =false;
        });
      }
    }
  }

 Future<void> saveAll() async {
 await ref.read(userServiceProvider).postUser(User.fromMap(givenUser));
  }
}

