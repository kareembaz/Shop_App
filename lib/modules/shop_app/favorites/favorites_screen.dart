import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/layout/shop_home/cubit/shop_cubit.dart';
import 'package:flutter_application/layout/shop_home/cubit/shop_states.dart';
import 'package:flutter_application/layout/shop_home/favorites_model.dart';
import 'package:flutter_application/shared/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var list = cubit.favroitesModel!.data;
        return ConditionalBuilder(
          condition: state is! ShoploadingGetFavoriteDataState,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildFavItem(list!.data![index], context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(start: 20.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey,
              ),
            ),
            itemCount:
                ShopCubit.get(context).favroitesModel!.data!.data!.length,
          ),
        );
      },
    );
  }

  Widget buildFavItem(favData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          color: Colors.white,
          height: 120.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.product!.image),
                    width: 120.0,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                  if (1 != 0)
                    Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(fontSize: 10.0, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product!.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.product!.price.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              height: 1.2, fontSize: 12.0, color: defoultColor),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        if (1 != 0)
                          Text(
                            model.product!.oldPrice.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                height: 1.2,
                                fontSize: 10.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.product!.id);
                            print(model.id);
                          },
                          icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor: ShopCubit.get(context)
                                          .favorites[model.product!.id] ==
                                      true
                                  ? defoultColor
                                  : Colors.grey,
                              child: Icon(
                                Icons.favorite_border,
                                size: 14.0,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
