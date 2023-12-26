import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/layout/shop_home/cubit/shop_cubit.dart';
import 'package:flutter_application/layout/shop_home/cubit/shop_states.dart';
import 'package:flutter_application/shared/components/components.dart';
import 'package:flutter_application/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  var fromKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        var cubit = ShopCubit.get(context);
        nameController.text = model!.data!.name;
        emailController.text = model!.data!.email;
        phoneController.text = model!.data!.phone;

        return ConditionalBuilder(
          condition: cubit.userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: fromKey,
              child: Column(
                children: [
                  if (state is ShoploadingGetUpdateDataState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFromField(
                    control: nameController,
                    inputType: TextInputType.name,
                    textlabel: 'Name',
                    prefix: Icons.person,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'THe Name must Be Emp';
                      }
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFromField(
                    control: emailController,
                    inputType: TextInputType.emailAddress,
                    textlabel: 'Email Adress',
                    prefix: Icons.person,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'THe Email must Be Emp';
                      }
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFromField(
                    control: phoneController,
                    inputType: TextInputType.phone,
                    textlabel: 'Phone',
                    prefix: Icons.person,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'THe Phone must Be Emp';
                      }
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultButton(
                      text: 'UPDATE',
                      function: () {
                        if (fromKey.currentState!.validate()) {
                          ShopCubit.get(context).UpdateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        }
                      }),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultButton(
                      text: 'logOUT',
                      function: () {
                        Signout(context);
                      }),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
