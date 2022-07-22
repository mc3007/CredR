import 'package:flutter/material.dart';
import 'package:ril_state/background.dart';
import 'package:ril_state/home.dart';
import 'package:ril_state/services/authenticate.dart';
import 'package:ril_state/signUp.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  var formKey=GlobalKey<FormState>();

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  String emailError='Enter your Email';
  String emailInvalidError='Enter a valid email';
  String passwordError='Enter Password';

  void clearText(){
    email.clear();
  }
  bool _obscureText= true;
  final GoogleSignInProvider signIn= GoogleSignInProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key:formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("Sign In", style: TextStyle(fontSize: 50),
                      ),
                      Text("Sign in with your Email and Password"),
                    ],
                  ),
                ),
                Card(
                  color: Colors.white.withOpacity(0.75),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: email,

                          validator: ( value) {
                            if(value!.isEmpty){
                              return emailError;
                            }else if(value!=null){
                              if(!value.contains("@")){
                                return emailInvalidError;
                              }
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your Email',
                            // suffixIcon: IconButton(icon: const Icon(Icons.clear), onPressed: clearText),
                            errorStyle: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: password,
                          validator: ( value) {
                            if(value!.isEmpty){
                              return passwordError;
                            }
                          },
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your Password',
                            suffixIcon: IconButton(
                                icon: _obscureText ? const Icon(Icons.visibility) : Icon(Icons.visibility_off),
                                onPressed: (){
                                  setState(() =>_obscureText=!_obscureText);
                                }),
                            errorStyle: const TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0,bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: null,
                        child: const Text("*Forgot Password*",
                          style: TextStyle(fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () async{
                    bool condition=await signInWithEmail(email.text,password.text);
                    if(formKey.currentState!.validate()) {
                      if(condition){
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return HomePage();
                            }));
                      }
                    }
                  },
                  child: const Text("Log in", style: TextStyle(color: Colors.white),),
                ),
                Text('Social LogIn can save your valuable time'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                    Divider(
                      color: Colors.black,
                      thickness: 2,
                      height: 5,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Icon(Icons.pan_tool_alt_outlined,),
                    Divider(
                      color: Colors.black,
                      thickness: 2,
                      height: 5,
                      indent: 20,
                      endIndent: 20,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton.icon(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: (){
                          signIn.googleLogIn(context);
                        },
                        icon: Image.asset('assets/google-logo.png', width: 30.0, height: 30.0,),
                        label: const Text("Google", style: TextStyle(color: Colors.black),)),
                    ElevatedButton.icon(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blueAccent),
                        onPressed: (){
                          signIn.googleLogIn(context);
                        },
                        icon: Image.asset('assets/fb logo.png', width: 30.0, height: 30.0,),
                        label: const Text("Facebook", style: TextStyle(color: Colors.black),)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Don't have an Account ? "),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return SignUp();
                              }));
                        },
                        child: const Text("Sign Up",
                          style:
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
