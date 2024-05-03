import 'dart:convert';

import 'package:apiflutter/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplexApiScreen extends StatefulWidget {
  const ComplexApiScreen({super.key});

  @override
  State<ComplexApiScreen> createState() => _ComplexApiScreenState();
}

class _ComplexApiScreenState extends State<ComplexApiScreen> {
  var data;
  Future<void> getComplexApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Complex Api'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getComplexApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                } else {
                  return ListView.builder(
                      itemCount: data.length ,
                      itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ReusableRow(title: 'Name', value: data[index]['name'].toString()),
                            ReusableRow(title: 'Username', value: data[index]['username'].toString()),
                            ReusableRow(title: 'Website', value: data[index]['website'].toString()),
                            ReusableRow(title: 'Email', value: data[index]['email'].toString()),
                            ReusableRow(title: 'Phone Number', value: data[index]['phone'].toString()),
                            ReusableRow(title: 'Company', value:"${ data[index]['company']['name'].toString()},${ data[index]['company']['catchPhrase'].toString()},${ data[index]['company']['bs'].toString()}"),


                            ReusableRow(title: 'Address', value: "${data[index]['address']['street']}, ${data[index]['address']['suite']}, ${data[index]['address']['city']},${data[index]['address']['zipcode']}"),
                            ReusableRow(title: 'Geo Code', value:"${ data[index]['address']['geo']['lat'].toString()},${ data[index]['address']['geo']['lng'].toString()}"),



                          ],
                        ),
                      ),
                    );
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
