import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data;
  Future<void> getUserDetails() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API Without Model")),
      body: Column(children: [
        Expanded(
            child: FutureBuilder(
          future: getUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          ReusableRow(
                              title: "Name",
                              value: data[index]['name'].toString()),
                          ReusableRow(
                              title: "UserName",
                              value: data[index]['username'].toString()),
                          ReusableRow(
                              title: "Address",
                              value:
                                  data[index]['address']['zipcode'].toString()),
                          ReusableRow(
                              title: "Geo",
                              value: data[index]['address']['geo']['lat']
                                  .toString())
                        ],
                      ),
                    );
                  });
            }
          },
        ))
      ]),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final title;
  final value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
