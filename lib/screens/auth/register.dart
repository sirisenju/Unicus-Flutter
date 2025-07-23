import 'package:flutter/material.dart';
import 'package:flutter_class_git/widgets/custom.textfield.widget.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:   SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: InwardArcClipper(),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(74, 67, 236, 1.0),
                  ),
                  child: Padding(padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sign Up", style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),),
                          Text("Create an account to join us", style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                          ),)
                        ],
                      )
                  ),
                ),

              ),

              Padding(
                padding: EdgeInsets.all(20),
                child:   Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          labelTxt: "First Name",
                          hintTxt: "John",
                          keyboardType: TextInputType.name,
                          obsureText: false,
                        )
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: CustomTextField(
                          labelTxt: "Last Name",
                          hintTxt: "Peter",
                          keyboardType: TextInputType.name,
                          obsureText: false,
                        )
                        ),
                      ]
                    ),
                    CustomTextField(
                      labelTxt: "Email",
                      hintTxt: "loe@gmail.com",
                      keyboardType: TextInputType.emailAddress,
                      obsureText: false,
                    ),
                    CustomTextField(
                      labelTxt: "Password",
                      hintTxt: "*******",
                      keyboardType: TextInputType.visiblePassword,
                      obsureText: false,
                    ),
                    CustomTextField(
                      labelTxt: "Confirm Password",
                      hintTxt: "*******",
                      keyboardType: TextInputType.visiblePassword,
                      obsureText: false,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text("Forgot password?", style: TextStyle(
                        color: Color.fromRGBO(74, 67, 236, 1.0),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(child: SizedBox(
                          height: 50,

                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(74, 67, 236, 1.0),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
                            ),
                            child: Text("Sign Up", style: TextStyle(
                                color: Colors.white
                            ),),
                          ),

                        ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}

class InwardArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start top-left
    path.moveTo(0, 0);
    // Top-right
    path.lineTo(size.width, 0);
    // Down right side
    path.lineTo(size.width, size.height);
    // Draw arc inward
    path.arcToPoint(
      Offset(0, size.height),
      radius: Radius.elliptical(size.width / 2, 50), // 50 is arc depth
      clockwise: false, // makes it curve inward
    );
    // Close path back to top-left
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
