import 'dart:convert';

import 'package:apiflutter/Models/PhotosModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/PostsModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // Fetch Description Api
  List<PostsModel> postList = [];



  Future<List<PostsModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      postList.clear();

      for (Map i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

//Fetch Photo With Details Api
  List<PhotosModel> photoList = [];
  Future<List<PhotosModel>> getPhotoApi() async{
    final responsePhoto = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var photoData = jsonDecode(responsePhoto.body.toString());

    if(responsePhoto.statusCode == 200){

      photoList.clear();

      for (Map i in photoData){
        PhotosModel photosModel = PhotosModel(title: i['title'], url: i['url'], id: i['id'],thumbnailUrl: i['thumbnailUrl']);
        photoList.add(photosModel);
      }
      return photoList;
    }else{
      return photoList;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("API with Null Safety"),
      ),
      body: Column(
        children: [
          //call The Api With Future Builder Widget
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {

                if (!snapshot.hasData) {
                  return Text('Loading');
                } else {


                  return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Title',
                                  style: TextStyle(
                                      color: CupertinoColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  postList[index].title.toString(),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Description',
                                  style: TextStyle(
                                      color: Colors.blueAccent.shade100,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  postList[index].body.toString(),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),



          // Black Color Space
          Container(
            height: 2, // Adjust the height as needed
            color: Colors.black87,
          ),



          //call The Image Api With Future Builder Widget
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: getPhotoApi(),
              builder: (context, AsyncSnapshot<List<PhotosModel>>snapshot) {

                if(!snapshot.hasData){

                  return  Text('Loading Data With Images');
                }else{

                  return ListView.builder(
                      itemCount:  photoList.length,
                      itemBuilder: (context,index){

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ListTile(

                              leading: Container(
                                height: 50,width: 50,

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(image: NetworkImage(snapshot.data![index].url.toString()))
                                ),
                              ),


                              title: Text(snapshot.data![index].title.toString()),
                              subtitle: Text('ID:'+snapshot.data![index].id.toString()),

                            ),
                          ),
                        );

                      });
                }

              },
            ),
          )
        ],
      ),
    );
  }
}
