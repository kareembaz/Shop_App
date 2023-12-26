import 'package:flutter/material.dart';
import 'package:flutter_application/models/user/user_model.dart';

class UserScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(
      id: 1,
      name: 'Mustafa Baz',
      phone: '+201090895253',
    ),
    UserModel(
      id: 2,
      name: ' Baz',
      phone: '+20123456789',
    ),
    UserModel(
      id: 3,
      name: 'Muz',
      phone: '+2010000000',
    ),
    UserModel(
      id: 4,
      name: 'Abdo Baz',
      phone: '+212111113',
    ),
    UserModel(
      id: 5,
      name: 'Mustafa ',
      phone: '+25253',
    ),
    UserModel(
      id: 6,
      name: 'Mustafa mustafe',
      phone: '+201090895',
    ),
    UserModel(
      id: 1,
      name: 'Mustafa Baz',
      phone: '+201090895253',
    ),
    UserModel(
      id: 2,
      name: ' Baz',
      phone: '+20123456789',
    ),
    UserModel(
      id: 3,
      name: 'Muz',
      phone: '+2010000000',
    ),
    UserModel(
      id: 4,
      name: 'Abdo Baz',
      phone: '+212111113',
    ),
    UserModel(
      id: 5,
      name: 'Mustafa ',
      phone: '+25253',
    ),
    UserModel(
      id: 6,
      name: 'Mustafa mustafe',
      phone: '+201090895',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 117, 146, 195),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUserItem(users[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
          ),
          child: Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.grey[300],
          ),
        ),
        itemCount: users.length,
      ),
    );
  }

  Widget buildUserItem(UserModel users) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              child: Text(
                '${users.id}',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${users.name}',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  '${users.phone}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
