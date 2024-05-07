

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {


  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  bool isImageSelected = false;


  Future getImage()async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);

    if(pickedFile!=null){
      image = File(pickedFile.path);
      setState(() {

      });
    }else{
      print('no image selected');
    }
  }


  Future<void> uploadImage()async{
    setState(() {
      showSpinner = true;
    });
    
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    
    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');

    var request = new http.MultipartRequest('POST', uri);

    request.fields['title']= 'Static Title';

    //assign the image
    var multiport = new http.MultipartFile(
      'image',
      stream,
      length
    );
    request.files.add(multiport);

    var response = await request.send();

    if(response.statusCode == 200){

      setState(() {
        showSpinner = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Image Uploaded"),
        ),
      );

      print('Image Uploaded');

    }else{

      print('Image Uploading Failed');

      setState(() {
        showSpinner = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Image Uploading Failed"),
        ),
      );
     }

  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(
        color: Colors.red,
      ),
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Upload Image/File To Rest API/Server'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    getImage();
                    setState(() {
                      isImageSelected = true;
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width ,
                    child: image == null ? Center(child: Text('Pick Image Please'),) : Image.file(
                      File(image!.path).absolute,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                GestureDetector(
                  onTap: (){
                    uploadImage();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: isImageSelected ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                         isImageSelected ? 'Upload Selected Image': 'Open Gallery'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
