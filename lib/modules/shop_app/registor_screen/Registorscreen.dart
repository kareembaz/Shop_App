import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/layout/shop_home/shop_layout.dart';
import 'package:flutter_application/modules/shop_app/registor_screen/registor_cubit/cubit.dart';
import 'package:flutter_application/modules/shop_app/registor_screen/registor_cubit/states.dart';
import 'package:flutter_application/shared/components/components.dart';
import 'package:flutter_application/shared/components/constants.dart';
import 'package:flutter_application/shared/network/local/cach_helper.dart';
import 'package:flutter_application/shared/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistorScreen extends StatelessWidget {
  var emailControll = TextEditingController();
  var passwordControll = TextEditingController();
  var nameControll = TextEditingController();
  var phoneControll = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => registorCubit(),
      child: BlocConsumer<registorCubit, registerStates>(
        listener: (context, state) {
          if (state is registorSccessState) {
            if (state.registorForTheModel.status) {
              print(state.registorForTheModel.message);
              print(state.registorForTheModel.data?.token);
              CachHelper.saveData(
                      key: 'token',
                      value: state.registorForTheModel.data?.token)
                  .then((value) {
                token = state.registorForTheModel.data!.token;
                navigatorTOAndEnd(context, shopLayout());
              });
              shoowtoast(
                  message: state.registorForTheModel.message,
                  state: ToastStates.SUCEESS);
            } else {
              print(state.registorForTheModel.message);
              shoowtoast(
                  message: state.registorForTheModel.message,
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                        'REGISTER',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 40.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Register now  to browse our hot office !!',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: nameControll,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' THe name must not be Empty !!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                          hintText: ' User Name ',
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: emailControll,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' THe Email must not be Empty !!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email_outlined),
                          hintText: '  Email address ',
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: passwordControll,
                        keyboardType: TextInputType.visiblePassword,
                        // onFieldSubmitted: (value) {
                        //   if (formKey.currentState!.validate()) {
                        //     registorCubit.get(context).userregistor(
                        //           email: emailControll.text,
                        //           password: passwordControll.text,
                        //           name: nameControll.text,
                        //           phone: phoneControll.text,
                        //         );
                        //   }
                        // },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' THe Password is more short !!';
                          }
                          return null;
                        },
                        obscureText: registorCubit.get(context).ispassWord,
                        decoration: InputDecoration(
                          hoverColor: defoultColor,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              registorCubit
                                  .get(context)
                                  .changePasswordVisility();
                            },
                            icon: Icon(registorCubit.get(context).suffic),
                          ),
                          hintText: 'Password Address',
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: phoneControll,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' THe Phone must not be Empty !!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                          hintText: ' Phone ',
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! registorLoadingState,
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
                                registorCubit.get(context).userregistor(
                                      email: emailControll.text,
                                      password: passwordControll.text,
                                      name: nameControll.text,
                                      phone: phoneControll.text,
                                    );
                              }
                            },
                            child: Text('REGISTER',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white)),
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ))));
        },
      ),
    );
  }
}
