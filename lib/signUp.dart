import 'package:flutter/material.dart';
import 'package:ril_state/background.dart';
import 'package:ril_state/logIn.dart';
import 'package:ril_state/home.dart';
import 'package:ril_state/services/authenticate.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("Sign Up", style: TextStyle(fontSize: 50),
                      ),
                      Text("Sign up with your Email and Password"),
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
                              labelText: 'Confirm Password',
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
                        )
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () async{
                    bool condition=await signUp(email.text, password.text);
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
                  child: const Text("Sign Up", style: TextStyle(color: Colors.white),),
                ),
                Text('Social LogIn can save your valuable time'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                    Divider(
                      color: Colors.blue,
                      thickness: 2,
                    ),
                    Icon(Icons.pan_tool_alt_outlined,),
                    Divider(
                      color: Colors.blue,
                      thickness: 2,
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
                         backgroundColor: Colors.blueAccent,
                       ),
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
                      const Text("Already have an Account ? "),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return LogIn();
                              }));
                        },
                        child: const Text("Log In",
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

