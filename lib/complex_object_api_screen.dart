import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/ProductsModel.dart';

class ComplexObjectApiScreen extends StatefulWidget {
  const ComplexObjectApiScreen({super.key});

  @override
  State<ComplexObjectApiScreen> createState() => _ComplexObjectApiScreenState();
}

class _ComplexObjectApiScreenState extends State<ComplexObjectApiScreen> {



  Future<ProductsModel> getProductApi() async {
    final respose = await http.get(
        Uri.parse('https://webhook.site/74f040b9-d5e0-4351-85b5-b587c14cd623'));
    var data = jsonDecode(respose.body.toString());

    if (respose.statusCode == 200) {

      return ProductsModel.fromJson(data);

    } else {

      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Products Model API"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ProductsModel>(
                future: getProductApi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(    //First List View Index Data
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            ListTile(
                               title: Text(snapshot.data!.data![index].shop!.name.toString()),
                              subtitle:  Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                              ),
                            ),

                            Container(
                              height: MediaQuery.of(context).size.height *.3 ,
                              width: MediaQuery.of(context).size.width *1,


                              child: ListView.builder( //Second List View calling the Index data for getting the  List of Images from Json
                                  scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.data![index].images!.length,
                                  itemBuilder: (context,position){


                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *.25 ,
                                    width: MediaQuery.of(context).size.width *.5,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(snapshot.data!.data![index].images![position].url.toString())
                                      )
                                    ),
                                  ),

                                );

                              }),
                            ),
                            Text(snapshot.data!.data![index].saleTitle.toString()),
                            Text('Size: '+snapshot.data!.data![index].size.toString()),
                            Text('Regular Price: '+snapshot.data!.data![index].price.toString()),
                            Text('Selling Price: '+snapshot.data!.data![index].salePrice.toString()),
                            Text(snapshot.data!.data![index].description.toString()),

                            Icon(
                                snapshot.data!.data![index].inWishlist! == false ? Icons.favorite_sharp : Icons.favorite_outline_rounded
                            ),


                          ],
                        );
                      },
                    );
                  } else {
                    return Text("Loading");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
