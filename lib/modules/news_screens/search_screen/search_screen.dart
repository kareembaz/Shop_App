import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/layout/news_home/ccbit/cubit.dart';
import 'package:flutter_application/layout/news_home/ccbit/states.dart';
import 'package:flutter_application/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class searchScreen extends StatelessWidget {
  var textcontroll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit, newsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isSearch = true;
        dynamic list = newsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Search Screen',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: textcontroll,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'The Search Must not be EMpty';
                    }
                  },
                  onChanged: (String value) {
                    newsCubit.get(context).getSearch(value);
                  },
                  // style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Seacrh',
                    // hintStyle: Theme.of(context).textTheme.bodyLarge,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              // Expanded(child: buildIemsNews(list, context)),
              Expanded(
                child: ConditionalBuilder(
                  condition: list.length > 0,
                  builder: (context) => ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildIemsNews(list[index], context),
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsetsDirectional.only(start: 25.0),
                      child: Container(
                        width: 1.0,
                        height: 1.0,
                        color: Colors.grey[300],
                      ),
                    ),
                    itemCount: list.length,
                  ),
                  fallback: (context) => Container(),
                  // isSearch
                  //     ? Container()
                  //     : Center(
                  //         child: CircularProgressIndicator(
                  //         color: Colors.orange,
                  //       )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
