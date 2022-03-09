import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:tutorial/Services/auth_service.dart';

class PhoneAuthPage extends StatefulWidget {
  PhoneAuthPage({Key? key}) : super(key: key);

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start = 60;
  bool wait = false;
  String buttonname = "Send";
  TextEditingController phonecontroller = TextEditingController();
  AuthCalss authCalss = AuthCalss();
  String verificationIdFinal = "";
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Phone Authendication"),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 280,
              height: 40,
              child: TextFormField(
                controller: phonecontroller,
                decoration: InputDecoration(
                    prefixText: '+91',
                    hintText: "Enter Mobile Number",
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(4),
                      child: InkWell(
                          onTap: wait
                              ? null
                              : () async {
                                  // starttimer();
                                  setState(() {
                                    start = 60;
                                    wait = true;
                                    buttonname = "Resend";
                                  });
                                  await authCalss.verifyPhonenumber(
                                      "+91 ${phonecontroller.text}",
                                      context,
                                      setData);
                                },
                          child: Text(
                            buttonname,
                            style: TextStyle(
                                color: wait ? Colors.green : Colors.red),
                          )),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 40,
              style: TextStyle(fontSize: 15),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                print("Completed: " + pin);
                setState(() {
                  smsCode = pin;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "enter otp in", style: TextStyle(color: Colors.black)),
              TextSpan(
                  text: "00:$start", style: TextStyle(color: Colors.black)),
              TextSpan(text: "sec", style: TextStyle(color: Colors.black)),
            ])),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                authCalss.signinWithPhonenumber(
                    verificationIdFinal, smsCode, context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20)),
                height: 40,
                width: 100,
                child: Center(child: Text("Verify")),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void starttimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(
      onsec,
      (timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
            wait = false;
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  void setData(verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    starttimer();
  }
}
