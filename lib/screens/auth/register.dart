import 'package:flutter/material.dart';
import 'package:flutter_class_git/widgets/custom.textfield.widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();


  bool _isloading = false;

  //SIGN UP A USER
  Future<void> signUpUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password
  }) async {

    try{
      setState(() {
        _isloading = true;
      });
      final supabase = Supabase.instance.client;
      final response = await supabase.auth.signUp(
          email: email,
          password: password
      );
      final user = response.user;
      if(user == null){
        print("Sign up failed");
      }
      else{
        print("Sign up successful");
        Navigator.pushReplacementNamed(context, '/login');
      }
      //INSERT INTO USER TABLE
      final userData = await supabase.from('users').insert({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'user_id': user?.id,
      });

      if(userData.error != null){
        print("Error inserting user data: ${userData.error}");
      }
    }
    catch(e){
      print("Error at signup: $e");
    }
    finally{
      if (mounted) {
        setState(() {
          _isloading = false;
        }
        );}
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: CustomTextField(
                            labelTxt: "First Name",
                            hintTxt: "John",
                            keyboardType: TextInputType.name,
                            obsureText: false,
                            controller: _firstNameController,
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
                            controller: _lastNameController,
                          )
                          ),
                        ]
                      ),
                      CustomTextField(
                        labelTxt: "Email",
                        hintTxt: "loe@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                        obsureText: false,
                        controller: _emailController,
                      ),
                      CustomTextField(
                        labelTxt: "Password",
                        hintTxt: "*******",
                        keyboardType: TextInputType.visiblePassword,
                        obsureText: false,
                        controller: _passwordController,
                      ),
                      CustomTextField(
                        labelTxt: "Confirm Password",
                        hintTxt: "*******",
                        keyboardType: TextInputType.visiblePassword,
                        obsureText: false,
                        controller: _confirmPasswordController,
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
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _isloading
                                    ? null
                                    : () async {
                                  if (_passwordController.text == _confirmPasswordController.text) {
                                    setState(() {
                                      _isloading = true;
                                    });

                                    try {
                                      print('Match password');
                                      await signUpUser(
                                        firstName: _firstNameController.text,
                                        lastName: _lastNameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );
                                      Navigator.pushNamed(context, '/login');
                                    } catch (e) {
                                      print("Signup error: $e");
                                    } finally {
                                      setState(() {
                                        _isloading = false;
                                      });
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromRGBO(74, 67, 236, 1.0),
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                ),
                                child: _isloading
                                    ? SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    strokeWidth: 2,
                                  ),
                                )
                                    : Text(
                                  "Sign Up",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
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
