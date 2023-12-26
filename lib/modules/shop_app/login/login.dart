import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/layout/shop_home/shop_layout.dart';
import 'package:flutter_application/modules/shop_app/registor_screen/Registorscreen.dart';
import 'package:flutter_application/modules/shop_app/login/cubit/cubit_login.dart';
import 'package:flutter_application/modules/shop_app/login/cubit/states_login.dart';
import 'package:flutter_application/shared/components/components.dart';
import 'package:flutter_application/shared/components/constants.dart';
import 'package:flutter_application/shared/network/local/cach_helper.dart';
import 'package:flutter_application/shared/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class shopLogin extends StatelessWidget {
  var emailControll = TextEditingController();
  var passwordControll = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginCubit(),
      child: BlocConsumer<loginCubit, loginStates>(
        listener: (context, state) {
          if (state is loginSccessState) {
            if (state.loginForTheModel.status) {
              print(state.loginForTheModel.message);
              print(state.loginForTheModel.data?.token);
              CachHelper.saveData(
                      key: 'token', value: state.loginForTheModel.data?.token)
                  .then((value) {
                token = state.loginForTheModel.data!.token;
                navigatorTOAndEnd(context, shopLayout());
              });
              shoowtoast(
                  message: state.loginForTheModel.message,
                  state: ToastStates.SUCEESS);
            } else {
              print(state.loginForTheModel.message);
              shoowtoast(
                  message: state.loginForTheModel.message,
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 40.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'login now  to browse our hot office !!',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: emailControll,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' THe email must not be Empty !!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email_outlined),
                          hintText: 'Email Address',
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: passwordControll,
                        keyboardType: TextInputType.visiblePassword,
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            loginCubit.get(context).userLogin(
                                  email: emailControll.text,
                                  password: passwordControll.text,
                                );
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' THe Password is more short !!';
                          }
                          return null;
                        },
                        obscureText: loginCubit.get(context).ispassWord,
                        decoration: InputDecoration(
                          hoverColor: defoultColor,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              loginCubit.get(context).changePasswordVisility();
                            },
                            icon: Icon(loginCubit.get(context).suffic),
                          ),
                          hintText: 'Email Address',
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! loginLoadingState,
                        builder: (context) => Container(
                          height: 50.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: defoultColor,
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                loginCubit.get(context).userLogin(
                                      email: emailControll.text,
                                      password: passwordControll.text,
                                    );
                              }
                            },
                            child: Text('LOGIN',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white)),
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account ? '),
                          TextButton(
                            onPressed: () {
                              navigatorTO(context, RegistorScreen());
                            },
                            child: Text('REGISTOR NOW ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: defoultColor)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
