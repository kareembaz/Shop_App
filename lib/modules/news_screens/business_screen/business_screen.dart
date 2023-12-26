import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/layout/news_home/ccbit/cubit.dart';
import 'package:flutter_application/layout/news_home/ccbit/states.dart';
import 'package:flutter_application/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class businessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit, newsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var listArticle = newsCubit.get(context).business;
        return ConditionalBuilder(
          condition: listArticle.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildIemsNews(listArticle[index], context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(start: 25.0),
              child: Container(
                width: 1.0,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            itemCount: listArticle.length,
          ),
          fallback: (context) => Center(
              child: CircularProgressIndicator(
            color: Colors.orange,
          )),
        );
      },
    );
  }
}
