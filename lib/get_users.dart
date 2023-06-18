import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/UserModel.dart';

class GetUserApi extends StatefulWidget {
  const GetUserApi({super.key});

  @override
  State<GetUserApi> createState() => _GetUserApiState();
}

class _GetUserApiState extends State<GetUserApi> {

  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi () async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var userData = jsonDecode(response.body.toString());

    if (response.statusCode == 200){
      for(Map i in userData){
        userList.add(UserModel.fromJson(i));
      }
      return userList ;
    }else{
      return userList ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('user api '),
        centerTitle: true,
      ),
    );
  }
}
