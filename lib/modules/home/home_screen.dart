import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: Icon(
          Icons.menu,
        ),
        title: Text('Welcome the first Page'),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notification_important)),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(
                        'https://images.caradisiac.com/logos/7/1/3/3/157133/S0-Cars-2-une-histoire-qui-fache-l-industrie-petroliere-70533.jpg'),
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: 200,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    color: Color.fromARGB(255, 187, 126, 121).withOpacity(0.3),
                    child: Text(
                      'Red Car',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
