import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextFormField usernameForm(){
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      controller: usernameController,
      validator: MultiValidator([
        RequiredValidator(
          errorText: "* Required"
        ),
      ]),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email or Username',
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
    );
  }

  TextFormField passwordForm(){
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      controller: passwordController,
      validator: MultiValidator([
        RequiredValidator(
          errorText: "* Required"
        ),
        MinLengthValidator(
          8, 
          errorText: 'Password is too short.\nIt must be at least 8 characters long.'
        ),
        MaxLengthValidator(
          16,
          errorText: 'Password is too long.\nIt is limited to 15 characters.'
        ),
      ]),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
    );
  }


  loginButton(BuildContext context){
    if(_formkey.currentState!.validate()){
      return Navigator.of(context).pushReplacementNamed('/home');
    }
    return null;
  }

  Form _loginForm(){
    return Form(
      key:_formkey,
      child: Column(
        children: [ 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: usernameForm(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: passwordForm(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: (){
                loginButton(context);
              },
              child: Text('Login'),
            ),
          ),
        ]
      )
    );
  }

  Widget _body(){
    return SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width/4,
                    height: MediaQuery.of(context).size.height/4,
                    child: Image.asset(
                      'assets/images/logo.png'
                    ),
                  ),
                ),
                _loginForm(),
              ],
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.green
          ),
          _body(),
        ]
      )
    );
  }
}