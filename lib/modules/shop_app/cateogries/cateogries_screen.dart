import 'package:flutter/material.dart';
import 'package:flutter_application/layout/shop_home/categories_model.dart';
import 'package:flutter_application/layout/shop_home/cubit/shop_cubit.dart';
import 'package:flutter_application/layout/shop_home/cubit/shop_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CateogriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ListView.separated(
        itemBuilder: (context, index) => buildCatItem(
            ShopCubit.get(context).cateogriesModel!.data!.data![index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(start: 20.0),
          child: Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.grey,
          ),
        ),
        itemCount: ShopCubit.get(context).cateogriesModel!.data!.data!.length,
      ),
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              fit: BoxFit.cover,
              width: 80.0,
              height: 80.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              model.name,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Spacer(),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.arrow_forward_ios_outlined)),
          ],
        ),
      );
}
