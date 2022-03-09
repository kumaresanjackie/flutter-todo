import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tutorial/Services/auth_service.dart';
import 'package:tutorial/pages/homepage.dart';
import 'package:tutorial/pages/phoneauthpage.dart';
import 'package:tutorial/pages/singin_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'dart:ui' as ui;

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool circular = false;
  AuthCalss authCalss = AuthCalss();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
                    child: Align(
                        child: Text(
                      "Sign Up",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.35,
                    left: MediaQuery.of(context).size.height * 0.05,
                    child:
                        card("assets/images/google.svg", "Connect With Google",
                            () async {
                      try {
                        await authCalss.googleSignIn(context);
                      } catch (e) {
                        final snackBar = SnackBar(content: Text(e.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }),
                  ),
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
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.8,
                    left: MediaQuery.of(context).size.height * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have an Account !",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInPage()));
                            },
                            child: Container(
                                child: Text("Log In",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)))),
                      ],
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.03,
                    left: MediaQuery.of(context).size.height * 0.19,
                    child: Container(
                        height: 180,
                        width: 250,
                        child: Image.asset("assets/images/vd.png")),
                  )
                ],
              ),
            ),
          )),
        ));
  }

//Google Authendication Card
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

//Email and Password Textfield
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

//Sign Up Button
  Widget signup() {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.createUserWithEmailAndPassword(
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
              child: Center(child: Text("Sign Up")),
            ),
    );
  }
}

//Colorful Background bubbles using Shape Makr
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    Path path0 = Path();

    canvas.drawPath(path0, paint0);

    Paint paint1 = Paint()
      ..color = const Color.fromARGB(255, 92, 184, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
    paint1.shader = ui.Gradient.linear(
        Offset(size.width * -0.06, size.height * 0.04),
        Offset(size.width * 0.14, size.height * 0.04),
        [Color(0xffe6e048), Color(0xff87dd45)],
        [0.00, 1.00]);

    Path path1 = Path();
    path1.moveTo(size.width * 0.0420000, size.height * -0.0189203);
    path1.cubicTo(
        size.width * 0.0820000,
        size.height * -0.0189203,
        size.width * 0.1420000,
        size.height * -0.0012614,
        size.width * 0.1420000,
        size.height * 0.0441473);
    path1.cubicTo(
        size.width * 0.1420000,
        size.height * 0.0693744,
        size.width * 0.1120000,
        size.height * 0.1072149,
        size.width * 0.0420000,
        size.height * 0.1072149);
    path1.cubicTo(
        size.width * 0.0020000,
        size.height * 0.1072149,
        size.width * -0.0580000,
        size.height * 0.0882947,
        size.width * -0.0580000,
        size.height * 0.0441473);
    path1.cubicTo(
        size.width * -0.0580000,
        size.height * 0.0189203,
        size.width * -0.0280000,
        size.height * -0.0189203,
        size.width * 0.0420000,
        size.height * -0.0189203);
    path1.close();

    canvas.drawPath(path1, paint1);

    Paint paint2 = Paint()
      ..color = const Color.fromARGB(255, 130, 194, 79)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
    paint2.shader = ui.Gradient.radial(
        Offset(size.width * 0.28, size.height * 0.20),
        size.width * 0.10,
        [Color(0xff5dde33), Color(0xff2cd6a1)],
        [0.00, 1.00]);

    Path path2 = Path();
    path2.moveTo(size.width * 0.2847000, size.height * 0.1324168);
    path2.cubicTo(
        size.width * 0.3247000,
        size.height * 0.1336781,
        size.width * 0.3847000,
        size.height * 0.1500757,
        size.width * 0.3847000,
        size.height * 0.1954844);
    path2.cubicTo(
        size.width * 0.3847000,
        size.height * 0.2207114,
        size.width * 0.3547000,
        size.height * 0.2585520,
        size.width * 0.2847000,
        size.height * 0.2585520);
    path2.cubicTo(
        size.width * 0.2447000,
        size.height * 0.2585520,
        size.width * 0.1847000,
        size.height * 0.2396317,
        size.width * 0.1847000,
        size.height * 0.1954844);
    path2.cubicTo(
        size.width * 0.1847000,
        size.height * 0.1702573,
        size.width * 0.2147000,
        size.height * 0.1336781,
        size.width * 0.2847000,
        size.height * 0.1324168);
    path2.close();

    canvas.drawPath(path2, paint2);

    Paint paint3 = Paint()
      ..color = const Color.fromARGB(255, 255, 206, 92)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
    paint3.shader = ui.Gradient.linear(
        Offset(size.width * 0.76, size.height * 0.91),
        Offset(size.width * 1.00, size.height * 0.91),
        [Color(0xffe95353), Color(0xffd9b546)],
        [0.00, 1.00]);

    Path path3 = Path();
    path3.moveTo(size.width * 0.8761600, size.height * 0.8371720);
    path3.cubicTo(
        size.width * 0.9238400,
        size.height * 0.8386983,
        size.width * 0.9972000,
        size.height * 0.8584132,
        size.width * 0.9972000,
        size.height * 0.9135091);
    path3.cubicTo(
        size.width * 0.9972000,
        size.height * 0.9435797,
        size.width * 0.9615000,
        size.height * 0.9898335,
        size.width * 0.8761600,
        size.height * 0.9898335);
    path3.cubicTo(
        size.width * 0.8284800,
        size.height * 0.9898335,
        size.width * 0.7551400,
        size.height * 0.9673310,
        size.width * 0.7551400,
        size.height * 0.9135091);
    path3.cubicTo(
        size.width * 0.7551400,
        size.height * 0.8834384,
        size.width * 0.7908000,
        size.height * 0.8386983,
        size.width * 0.8761600,
        size.height * 0.8371720);
    path3.close();

    canvas.drawPath(path3, paint3);

    Paint paint4 = Paint()
      ..color = const Color.fromARGB(255, 92, 255, 125)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
    paint4.shader = ui.Gradient.linear(
        Offset(size.width * -0.02, size.height * 0.94),
        Offset(size.width * 0.31, size.height * 0.94),
        [Color(0xff2874df), Color(0xffa21dce)],
        [0.00, 1.00]);

    Path path4 = Path();
    path4.moveTo(size.width * 0.1460000, size.height * 0.8404390);
    path4.cubicTo(
        size.width * 0.2098600,
        size.height * 0.8424445,
        size.width * 0.3074000,
        size.height * 0.8686428,
        size.width * 0.3074000,
        size.height * 0.9422301);
    path4.cubicTo(
        size.width * 0.3074000,
        size.height * 0.9824924,
        size.width * 0.2596600,
        size.height * 1.0440212,
        size.width * 0.1460000,
        size.height * 1.0440212);
    path4.cubicTo(
        size.width * 0.0821600,
        size.height * 1.0440212,
        size.width * -0.0154000,
        size.height * 1.0139127,
        size.width * -0.0154000,
        size.height * 0.9422301);
    path4.cubicTo(
        size.width * -0.0154000,
        size.height * 0.9019551,
        size.width * 0.0323400,
        size.height * 0.8424445,
        size.width * 0.1460000,
        size.height * 0.8404390);
    path4.close();

    canvas.drawPath(path4, paint4);

    Paint paint5 = Paint()
      ..color = const Color.fromARGB(255, 233, 92, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
    paint5.shader = ui.Gradient.linear(
        Offset(size.width * 0.53, size.height * 0.15),
        Offset(size.width * 1.00, size.height * 0.15),
        [Color(0xffe73235), Color(0xffb2d91f)],
        [0.00, 1.00]);

    Path path5 = Path();
    path5.moveTo(size.width * 0.7610200, size.height * 0.0044904);
    path5.cubicTo(
        size.width * 0.8538400,
        size.height * 0.0075050,
        size.width * 0.9969000,
        size.height * 0.0458502,
        size.width * 0.9969000,
        size.height * 0.1532417);
    path5.cubicTo(
        size.width * 0.9969000,
        size.height * 0.2117810,
        size.width * 0.9272600,
        size.height * 0.3020055,
        size.width * 0.7610200,
        size.height * 0.3020055);
    path5.cubicTo(
        size.width * 0.6681800,
        size.height * 0.3020055,
        size.width * 0.5251600,
        size.height * 0.2580853,
        size.width * 0.5251600,
        size.height * 0.1532417);
    path5.cubicTo(
        size.width * 0.5251600,
        size.height * 0.0946897,
        size.width * 0.5948000,
        size.height * 0.0075050,
        size.width * 0.7610200,
        size.height * 0.0044904);
    path5.close();

    canvas.drawPath(path5, paint5);

    Paint paint6 = Paint()
      ..color = const Color.fromARGB(255, 255, 92, 175)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path6 = Path();
    path6.moveTo(size.width * 0.2498600, size.height * 0.3990414);
    path6.cubicTo(
        size.width * 0.2796600,
        size.height * 0.4000505,
        size.width * 0.3270600,
        size.height * 0.4124748,
        size.width * 0.3270600,
        size.height * 0.4477296);
    path6.cubicTo(
        size.width * 0.3270600,
        size.height * 0.4665111,
        size.width * 0.3042600,
        size.height * 0.4964051,
        size.width * 0.2498600,
        size.height * 0.4964051);
    path6.cubicTo(
        size.width * 0.2200800,
        size.height * 0.4964051,
        size.width * 0.1726800,
        size.height * 0.4820383,
        size.width * 0.1726800,
        size.height * 0.4477296);
    path6.cubicTo(
        size.width * 0.1726800,
        size.height * 0.4289354,
        size.width * 0.1954800,
        size.height * 0.4000505,
        size.width * 0.2498600,
        size.height * 0.3990414);
    path6.close();

    canvas.drawPath(path6, paint6);

    Paint paint7 = Paint()
      ..color = const Color.fromARGB(255, 233, 155, 133)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path7 = Path();
    path7.moveTo(size.width * 0.6076800, size.height * 0.6207114);
    path7.cubicTo(
        size.width * 0.6751400,
        size.height * 0.6228179,
        size.width * 0.7788000,
        size.height * 0.6505172,
        size.width * 0.7788000,
        size.height * 0.7286453);
    path7.cubicTo(
        size.width * 0.7788000,
        size.height * 0.7711907,
        size.width * 0.7285400,
        size.height * 0.8365666,
        size.width * 0.6076800,
        size.height * 0.8365666);
    path7.cubicTo(
        size.width * 0.5402400,
        size.height * 0.8365666,
        size.width * 0.4365400,
        size.height * 0.8048688,
        size.width * 0.4365400,
        size.height * 0.7286453);
    path7.cubicTo(
        size.width * 0.4365400,
        size.height * 0.6861125,
        size.width * 0.4868000,
        size.height * 0.6228179,
        size.width * 0.6076800,
        size.height * 0.6207114);
    path7.close();

    canvas.drawPath(path7, paint7);

    Paint paint8 = Paint()
      ..color = const Color.fromARGB(255, 178, 255, 92)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path8 = Path();
    path8.moveTo(size.width * 0.8099000, size.height * 0.4050202);
    path8.cubicTo(
        size.width * 0.8328200,
        size.height * 0.4057770,
        size.width * 0.8646600,
        size.height * 0.4142281,
        size.width * 0.8646600,
        size.height * 0.4395560);
    path8.cubicTo(
        size.width * 0.8646600,
        size.height * 0.4539985,
        size.width * 0.8490600,
        size.height * 0.4740792,
        size.width * 0.8099000,
        size.height * 0.4740792);
    path8.cubicTo(
        size.width * 0.7870000,
        size.height * 0.4740792,
        size.width * 0.7551600,
        size.height * 0.4642407,
        size.width * 0.7551600,
        size.height * 0.4395560);
    path8.cubicTo(
        size.width * 0.7551600,
        size.height * 0.4251009,
        size.width * 0.7707600,
        size.height * 0.4057770,
        size.width * 0.8099000,
        size.height * 0.4050202);
    path8.close();

    canvas.drawPath(path8, paint8);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

  // Widget gp(String name, Function()? ontap) {
  //   return InkWell(
  //     onTap: ontap,
  //     child: Container(

  //       decoration: BoxDecoration(
  //           color: Colors.amber, borderRadius: BorderRadius.circular(20)),
  //       height:,
  //       width: 100,
  //       child: Center(child: Text(name)),
  //     ),
  //   );
  // }
      // SizedBox(
                  //   height: 20,
                  // ),
                  // gp("Phone SignUp", () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => PhoneAuthPage()));
                  // }),
