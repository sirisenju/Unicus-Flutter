import 'package:flutter/material.dart';
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Text("Find Your Perfect Home", style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
              ),),
              Text("Find Your Perfect Home", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.black

              ),),
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 370,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(150), topRight: Radius.circular(150)),
                    image: DecorationImage(image: AssetImage("assets/house.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 240, 245, 1.0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Container(
                        height: 50,
                        child:  GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Center(
                            child: Text(
                              "SignUp",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )),
                      Expanded(child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(74, 67, 236, 1.0),
                          borderRadius: BorderRadius.circular(30),

                        ),
                        child:  GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Center(
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )),
                      // Expanded(child: Container(
                      //   height: 70,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       onSubmit();
                      //       Navigator.pushReplacementNamed(context, '/home');
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(5),
                      //       ),
                      //     ),
                      //     child: Text("Submit", style: TextStyle(
                      //         color: Colors.black
                      //     ),),
                      //   ),
                      //
                      // )),
                      // Expanded(child: Container(
                      //   height: 70,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       onSubmit();
                      //       Navigator.pushReplacementNamed(context, '/home');
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(5),
                      //       ),
                      //     ),
                      //     child: Text("Submit", style: TextStyle(
                      //         color: Colors.black
                      //     ),),
                      //   ),
                      //
                      // )),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
