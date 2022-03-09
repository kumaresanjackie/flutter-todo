import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tutorial/Services/auth_service.dart';
import 'package:tutorial/pages/homepage.dart';
import 'package:tutorial/pages/phoneauthpage.dart';
import 'package:tutorial/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  AuthCalss authCalss = AuthCalss();

  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CustomPaint(
          size: Size(
              MediaQuery.of(context).size.width,
              (MediaQuery.of(context).size.width * 1.5856)
                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPSCustomPainter(),
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.26,
                  left: MediaQuery.of(context).size.height * 0.18,
                  child: Center(
                      child: Text("Log In",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)))),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.35,
                left: MediaQuery.of(context).size.height * 0.05,
                child: card("assets/images/google.svg", "Log In With Google",
                    () async {
                  await authCalss.googleSignIn(context);
                }),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // gp("Phone SignIn", () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => PhoneAuthPage()));
              // }),
              // SizedBox(
              //   height: 20,
              // ),
              // Text("Or"),
              // SizedBox(
              //   height: 20,
              // ),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.44,
                  left: MediaQuery.of(context).size.height * 0.25,
                  child: Text("Or")),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.48,
                left: MediaQuery.of(context).size.height * 0.05,
                child: Column(
                  children: [
                    textfield("Email", _email, false),
                    SizedBox(
                      height: 20,
                    ),
                    textfield("Password", _password, true),
                    SizedBox(
                      height: 20,
                    ),
                    signup(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              // textfield("Email", _email, false),
              // SizedBox(
              //   height: 20,
              // ),
              // textfield("Password", _password, true),
              // SizedBox(
              //   height: 20,
              // ),
              // signup(),
              // SizedBox(
              //   height: 20,
              // ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.8,
                left: MediaQuery.of(context).size.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Container(
                            child: Text(
                          "Sign up Here!",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )))
                  ],
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Text("Forgot Password?"),
            ],
          ),
        ),
      )),
    ));
  }

  Widget card(String image, String name, Function()? ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        color: Colors.transparent,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21),
              side: BorderSide(
                  width: 1, color: Color.fromARGB(255, 139, 147, 216))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                image,
                // "assets/images/google.svg",
                height: 30,
                width: 30,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Widget gp(String name, Function()? ontap) {
  //   return InkWell(
  //     onTap: ontap,
  //     child: Container(
  //       decoration: BoxDecoration(
  //           color: Colors.amber, borderRadius: BorderRadius.circular(20)),
  //       height: 40,
  //       width: 100,
  //       child: Center(child: Text(name)),
  //     ),
  //   );
  // }

  Widget textfield(
      String hint, TextEditingController _controller, bool obsecurtext) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 60,
      child: TextFormField(
        obscureText: obsecurtext,
        controller: _controller,
        decoration: InputDecoration(
          labelStyle: TextStyle(fontSize: 15),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide:
                BorderSide(width: 1, color: Color.fromARGB(255, 226, 135, 230)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide:
                BorderSide(width: 1, color: Color.fromARGB(255, 231, 127, 127)),
          ),
          hintText: hint,
        ),
      ),
    );
  }

  Widget signup() {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = false;
        });
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.signInWithEmailAndPassword(
                  email: _email.text, password: _password.text);
          setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
          print(userCredential.user!.email.toString());
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: circular
          ? CircularProgressIndicator()
          : Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(179, 48, 199, 226)),
              height: 50,
              width: 130,
              child: Center(child: Text("Log In")),
            ),
    );
  }
}
