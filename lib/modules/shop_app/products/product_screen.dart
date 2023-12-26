import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/layout/shop_home/categories_model.dart';
import 'package:flutter_application/layout/shop_home/cubit/shop_cubit.dart';
import 'package:flutter_application/layout/shop_home/cubit/shop_states.dart';
import 'package:flutter_application/layout/shop_home/home_model.dart';
import 'package:flutter_application/shared/components/components.dart';
import 'package:flutter_application/shared/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopSucessSellectFavState) {
            if (state.model.status == false) {
              shoowtoast(
                  message: state.model.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          var list = cubit.homeModel;
          var list2 = cubit.cateogriesModel;

          return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.cateogriesModel != null,
            builder: (context) => productBuilder(list!, list2!, context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget productBuilder(HomeModel model, CateogriesModel model2, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildCategoryItem(model2.data!.data![index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.0,
                      ),
                      itemCount: model2.data!.data!.length,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.8,
                children: List.generate(
                    model.data.products.length,
                    (index) =>
                        buildGridProuct(model.data.products[index], context)),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(
              0.8,
            ),
            width: 100.0,
            child: Text(
              model.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      );

  Widget buildGridProuct(productsModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (model.discount != 0)
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.3),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  '${model.price.round()}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      height: 1.2, fontSize: 12.0, color: defoultColor),
                ),
                SizedBox(
                  width: 10.0,
                ),
                if (model.discount != 0)
                  Text(
                    '${model.oldPrice.round()}',
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
                    ShopCubit.get(context).changeFavorites(model.id);
                    print(model.inFavorites);
                    print(model.id);
                  },
                  icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor:
                          // ShopCubit.get(context).changeOFColorFav(model),
                          ShopCubit.get(context).favorites[model.id] == true
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
      );
}
