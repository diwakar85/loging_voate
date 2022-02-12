import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';
import 'signUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController logInController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  String userName = "";
  String userPassword = "";

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.deepOrangeAccent,
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.1),
                  Icon(Icons.account_balance_sharp, size: width*0.15, color: Colors.white),
                  SizedBox(height: MediaQuery.of(context).size.height*0.02),
                  Text("Voting Application", style: TextStyle(color: Colors.white, fontSize: width*0.065),),
                  SizedBox(height: MediaQuery.of(context).size.height*0.25),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width*0.1,
                        MediaQuery.of(context).size.height*0.02,
                        MediaQuery.of(context).size.width*0.1, 0),
                    child: TextFormField(
                      controller: logInController,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (val){
                        setState(() {
                          userName = val!;
                        });
                      },
                      validator: (val){
                        if((val!.length<10))
                        {
                          return "Please enter valid email";
                        }
                      },
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Colors.pink,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025),
                          child: const Icon(Icons.email, color: Colors.red),
                        ),
                        border: const OutlineInputBorder(),
                        hintText: "Email",
                        labelStyle: const TextStyle(fontSize: 16),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width*0.03,
                          vertical: MediaQuery.of(context).size.height*0.025,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(27),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width*0.1,
                        MediaQuery.of(context).size.height*0.03,
                        MediaQuery.of(context).size.width*0.1, 0),
                    child: TextFormField(
                      controller: passwordController2,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val){
                        if((val!.length<8))
                        {
                          return "Please enter atleast 8 characters";
                        }
                      },
                      onSaved: (val){
                        setState(() {
                          userPassword = val!;
                        });
                      },
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Colors.pink,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025),
                          child: const Icon(Icons.lock, color: Colors.red),
                        ),
                        border: const OutlineInputBorder(),
                        hintText: "Password",
                        labelStyle: const TextStyle(fontSize: 16),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width*0.03,
                          vertical: MediaQuery.of(context).size.height*0.025,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(27),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width*0.1,
                        MediaQuery.of(context).size.height*0.025,
                        MediaQuery.of(context).size.width*0.1, 0),
                    child: ElevatedButton(
                      child: const Center(
                        child: Text("Login"),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                        shape: const StadiumBorder(),
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width*0.03,
                          vertical: MediaQuery.of(context).size.height*0.025,
                        ),
                      ),
                      onPressed: (){
                        emailLogin(logInController.text.toString(), passwordController2.text.toString());
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.2, top: MediaQuery.of(context).size.height*0.07),
                    child: Row(
                      children: [
                        const Text("Don't have an account ", style: TextStyle(fontSize: 18),),
                        GestureDetector(
                          child: const Text("SignUp", style: TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.underline),
                          ),
                          onTap:(){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignupPage()), (route) => false);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  emailLogin(String logIn, String logInPassword) async {

    await FirebaseAuth.instance.signInWithEmailAndPassword(email: logIn, password: logInPassword);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05, left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
        behavior: SnackBarBehavior.floating,
        content: Text('LogIn successfully with Email:\n$logIn',
          style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.045),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
