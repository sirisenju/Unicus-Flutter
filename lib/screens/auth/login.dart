import 'package:flutter/material.dart';
import 'package:flutter_class_git/widgets/custom.textfield.widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isloading = false;

  //LOGIN FUNCTION
  Future<void> loginUser({
    required String email,
    required String password
    }) async{

    try{
      setState(() {
        _isloading = true;
      });
      final supabase = Supabase.instance.client;

      final response = await supabase.auth.signInWithPassword(
          email: email,
          password: password
      );
      final user = response.user;
      print("User response: $user");
      final profile = user!.role;
      final profileResponse = await supabase
          .from('users')
          .select()
          .eq('user_id', user.id)
          .single();

      print("Profile Resposne: $profileResponse");
      final status = profileResponse["role"];
      print("Status: $status");

      if(status == "admin"){
        Navigator.pushReplacementNamed(context, '/admin');
      }
      else{
        Navigator.pushReplacementNamed(context, '/home');
      }
      if(user == null){
        print("Login failed");
      }
    }
    catch(e){
      print("Error at login: $e");
    }

  }

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
                          Text("Welcome Back", style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),),
                          Text("Login to your account", style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                          ),)
                        ],
                      )
                  ),
                ),

              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.all(20),
              child:   Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    labelTxt: "Email",
                    hintTxt: "loe@gmail.com",
                    keyboardType: TextInputType.emailAddress,
                    obsureText: false,
                    controller: _email,
                  ),
                  CustomTextField(
                    labelTxt: "Password",
                    hintTxt: "*******",
                    keyboardType: TextInputType.visiblePassword,
                    obsureText: false,
                    controller: _password,
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
                    height: 60,
                  ),
                  Row(
                    children: [
                      Expanded(child: SizedBox(
                        height: 50,

                        child: ElevatedButton(
                          onPressed: () {
                            loginUser(email: _email.text, password: _password.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(74, 67, 236, 1.0),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                          child: Text("Login", style: TextStyle(
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


