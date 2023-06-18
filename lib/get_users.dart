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
        title: const Text('user api'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return const Center(child: CircularProgressIndicator());
                  }else{
                    return ListView.builder(
                      itemCount: userList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  RowConponent(
                                      title: 'Name:',
                                      value: userList[index].name.toString()
                                  ),
                                  RowConponent(
                                      title: 'User Name:',
                                      value: userList[index].username.toString()
                                  ),
                                  RowConponent(
                                      title: 'Email:',
                                      value: userList[index].email.toString()
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                    );
                  }
                }
            ),
          )
        ],
      )
    );
  }
}


class RowConponent extends StatelessWidget {

  String title, value;

  RowConponent({super.key , required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(title),
        Text(value)
    ]
    );
  }
}

