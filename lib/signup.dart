
import 'package:apiflutter/user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class SignUpScreen extends StatefulWidget {


  const SignUpScreen({super.key});


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {



  //Controller uses for to store the Data
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

/**
//Login with API
  void login(String email,password) async{

    try{
      Response response = await post(
        Uri.parse('https://reqres.in/api/register'),
        body:{
          'email':email, //eve.holt@reqres.in
          'password':password //pistol
        }
      );

      if(response.statusCode == 200){

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Account Created Successfully"),
        ));


      }else{

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid Email or Password"),
        ));

      }

    }catch(e){
      print(e.toString());
    }
    
  }
  */


  // Use API to Login/SignUp and Navigate to the Next Screen
  Future<void> login(String email, String password) async {
    try {
      Response response = await post(
        Uri.parse('https://reqres.in/api/register'),
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account Created Successfully"),
          ),
        );

        // Navigate to the HomeScreen on successful account creation
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => UserDetailScreen(), // Replace HomeScreen with your actual home screen widget
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid Email or Password"),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sign Up Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter Your Email "eve.holt@reqres.in"'
              ),
            ),

            const SizedBox(height: 10,),

            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Enter Your Password'
              ),
            ),

            const SizedBox(height: 40,),

           GestureDetector(
             onTap: (){
               login(emailController.text.toString(),passwordController.text.toString());


             },
             child: Container(
               height: 50,
               decoration: BoxDecoration(
                 color: Colors.green,
                 borderRadius: BorderRadius.circular(10)
               ),
               child: Center(
                 child: Text('Sign Up'),
               ),
             ),
           )



          ],
        ),
      ),
    );
  }

}
