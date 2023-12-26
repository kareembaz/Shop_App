import 'package:flutter/material.dart';
import 'package:flutter_application/layout/shop_home/cubit/shop_cubit.dart';
import 'package:flutter_application/layout/shop_home/search_model.dart';
import 'package:flutter_application/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:flutter_application/modules/shop_app/search/cubit/search_states.dart';
import 'package:flutter_application/shared/components/components.dart';
import 'package:flutter_application/shared/themes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: prefer_const_constructors
class SearchScreen extends StatelessWidget {
  var fromKey = GlobalKey<FormState>();
  var textController = TextEditingController();
  bool isOldPrice = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // var list = SearchCubit.get(context).searchModel!.data;
          // SearchCubit.get(context)
          // .searchModel!
          // .data!
          // .data!
          // .length,

          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: fromKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFromField(
                          control: textController,
                          inputType: TextInputType.text,
                          textlabel: 'Search',
                          prefix: Icons.search,
                          onFieldSubmitted: (value) {
                            SearchCubit.get(context).search(value);
                          },
                          validator: (value) {
                            return 'Enter text to search';
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchScuessState)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => buildSEAItem(
                                SearchCubit.get(context)
                                    .searchModel!
                                    .data!
                                    .data![index],
                                context,
                                isOldPrice = false),
                            separatorBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 20.0),
                              child: Container(
                                height: 1.0,
                                width: double.infinity,
                                color: Colors.grey,
                              ),
                            ),
                            itemCount: SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data!
                                .length,
                          ),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget buildSEAItem(Product model, context, isOldPrice) => Padding(
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
                    image: NetworkImage(model.image),
                    width: 120.0,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                  if (model.discount != 0 && isOldPrice)
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
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.price.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              height: 1.2, fontSize: 12.0, color: defoultColor),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        if (model.discount != 0 && isOldPrice)
                          Text(
                            model.oldPrice.toString(),
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
                            print(model.id);
                          },
                          icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor:
                                  ShopCubit.get(context).favorites[model.id] ==
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
