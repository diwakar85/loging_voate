import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'logInPage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  String email = "";
  String password = "";
  TextEditingController signUpController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();

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
              height: height,
              width: width,
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
                    padding: EdgeInsets.fromLTRB(width*0.1, height*0.02, width*0.1, 0),
                    child: TextFormField(
                      controller: signUpController,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (val){
                        setState(() {
                          email = val!;
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
                      controller: passwordController1,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val){
                        if((val!.length<6))
                        {
                          return "Please enter atLeast 6 characters";
                        }
                      },
                      onSaved: (value){
                        password = value!;
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
                          child: Text("Sign Up"),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                          shape: const StadiumBorder(),
                          padding: EdgeInsets.symmetric(
                                      horizontal: width*0.03,
                                      vertical: height*0.025,
                          ),
                        ),
                        onPressed:(){
                          emailRegister(signUpController.text.toString(), passwordController1.text.toString());
                        },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.2, top: MediaQuery.of(context).size.height*0.07),
                      child: Row(
                        children: [
                          const Text("Already existing user ", style: TextStyle(fontSize: 18),),
                          GestureDetector(
                              child: const Text("Login", style: TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.underline),
                              ),
                              onTap: (){
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
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

  emailRegister(String signUp, String signUpPassword) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: signUp, password: signUpPassword);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05, left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
        behavior: SnackBarBehavior.floating,
        content: Text('Sign up successfully with Email:\n$signUp',
          style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.045),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
