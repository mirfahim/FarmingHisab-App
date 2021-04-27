
import 'package:farming_app/Pages/Authentication/LoginUser.dart';
import 'package:farming_app/Pages/Authentication/SignUpForm.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 600,
                width:400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 350,
                      width: 444,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/icons/wallet.png"))),
                    ),
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: <Widget>[
                          Text(
                            "Ready To Start Shopping Sign Up",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "To get Started",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        color: Color(0xff746bc9),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => SignUpForm(),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => UserLogin(),
                              ),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff7746bc9),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}