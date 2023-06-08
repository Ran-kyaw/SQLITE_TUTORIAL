import 'package:flutter/material.dart';
import 'package:sqlite_crud/Models/user.dart';

import '../Services/userServices.dart';

class EditUser extends StatefulWidget {

  final User user;
  const EditUser({super.key,required this.user});
  
  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {

  var _userNameController = TextEditingController();
  var _userContactController = TextEditingController();
  var _userDescriptionController = TextEditingController();
  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;
  var _userService = userSrvice();

  @override
  void initState() {
    setState(() {
      _userNameController.text = widget.user.name!;
      _userContactController.text = widget.user.contact!;
      _userDescriptionController.text = widget.user.description!;
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SQLite CRUD'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit User',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText:
                        _validateName ? 'Name Value Can\'t Be Empty' : null,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: _userContactController,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    hintText: 'Enter Contact',
                    labelText: 'Contact',
                    errorText: _validateContact
                        ? 'Contact Value Can\'t Be Empty'
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: _userDescriptionController,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    hintText: 'Enter Description',
                    labelText: 'Description',
                    errorText: _validateDescription
                        ? 'Description Value Can\'t Be Empty'
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.teal,
                            textStyle: TextStyle(fontSize: 15)),
                        onPressed: () async {
                          setState(() {
                            _userNameController.text.isEmpty
                                ? _validateName = true
                                : _validateName = false;
                            _userContactController.text.isEmpty
                                ? _validateContact = true
                                : _validateContact = false;
                            _userDescriptionController.text.isEmpty
                                ? _validateDescription = true
                                : _validateDescription = false;
                          });

                          if (_validateName == false &&
                              _validateContact == false &&
                              _validateDescription == false) {
                            // print("Good Data Can Save");

                            var _user = User();
                            _user.id=widget.user.id;
                            _user.name = _userNameController.text;
                            _user.contact = _userContactController.text;
                            _user.description = _userDescriptionController.text;
                            var result = await _userService.updateUser(_user);

                          Navigator.pop(context,result);
                          }
                        },
                        child:const Text('Update Details')),
                    const SizedBox(
                      width: 10.0,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            textStyle: TextStyle(fontSize: 15)),
                        onPressed: () {
                          _userNameController.text = '';
                          _userContactController.text = '';
                          _userDescriptionController.text = '';
                        },
                        child: Text('Clear Details'))
                  ],
                )
              ],
            ),
          ),
        )
        );
  }
}