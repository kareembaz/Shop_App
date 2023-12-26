import 'package:flutter/material.dart';
import 'package:flutter_application/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var EmailController = TextEditingController();

  var PasswordController = TextEditingController();
  bool ispassword = true;
  var fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: fromKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFromField(
                    control: EmailController,
                    inputType: TextInputType.emailAddress,
                    textlabel: 'EmAiL Address',
                    prefix: Icons.email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'EmAiL must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFromField(
                    control: PasswordController,
                    inputType: TextInputType.visiblePassword,
                    textlabel: 'PaSsWoRd',
                    prefix: Icons.lock,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'PaSsWoRd must  not be empty';
                      }
                      return null;
                    },
                    suffix:
                        ispassword ? Icons.visibility : Icons.visibility_off,
                    onChanged: (value) => print(value),
                    onFieldSubmitted: (value) => print(value),
                    showPassword: ispassword,
                    ispassWord: () {
                      setState(() {
                        ispassword = !ispassword;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  // MaterialButton(
                  //   child: Text('Login'),
                  //   onPressed: () {
                  //     if (fromKey.currentState!.validate()) {
                  //       fromKey.currentState!.save();
                  //       print(EmailController.text);
                  //       print(PasswordController.text);
                  //     }
                  //   },
                  // ),
                  defaultButton(
                    text: 'LogiN',
                    function: () {
                      // if (fromKey.currentState != null) {
                      if (fromKey.currentState!.validate()) {
                        fromKey.currentState!.save();
                        print(EmailController.text);
                        print(PasswordController.text);
                      }
                      // }
                    },
                    isUppercase: false,
                    color: Colors.blue,
                    radis: 10.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultButton(
                    text: 'ReGiTsOr',
                    function: () {
                      print(EmailController.text);
                      print(PasswordController.text);
                    },
                    color: const Color.fromARGB(255, 243, 33, 201),
                    width: 200.0,
                    radis: 20.0,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Register Now '),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
