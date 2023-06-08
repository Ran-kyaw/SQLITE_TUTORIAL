import 'package:sqlite_crud/Models/DB_Helper/repository.dart';
import 'package:sqlite_crud/Models/user.dart';

class userSrvice {
  late Repository _repository;
  userSrvice() {
    _repository = Repository();
  }
  
  //Save user
  saveUser(User user) async {
    return await _repository.insertData("users", user.userMap());
  }
  //Read All User
  readAllUsers() async{
    return await _repository.readData("users");  
  }

  //Edit User
  updateUser(User user) async{
    return await _repository.updateData('users', user.userMap());
  }
  
  //Deleted User
  deleteUser(userId) async{
      return await _repository.deleteDataById('users', userId);
  }
}
