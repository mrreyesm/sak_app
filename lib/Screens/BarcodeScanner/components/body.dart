import 'dart:ui';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Login/components/background.dart';
import 'package:sak_app/Screens/Sensor%20Menu/sensorMenu.dart';
import 'package:sak_app/db/sak_database.dart';
import 'package:sak_app/model/sak.dart';

class UserCardWidget extends StatelessWidget {
  UserCardWidget({
    Key? key,
    required this.user,
    required this.index,
  }) : super(key: key);

  final User user;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final minHeight = getMinHeight(index);

    return Card(
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              user.userName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}



class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}


class _UsersPageState extends State<UsersPage> {
  late List<User> users;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshUsers();
  }

  @override
  void dispose() {
    SakDatabase.instance.close();

    super.dispose();
  }

  Future refreshUsers() async {
    setState(() => isLoading = true);

    this.users = await SakDatabase.instance.readAllUsers();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : users.isEmpty
                  ? Text(
                      'No Users',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildUsers(),
        ),
      );

  Widget buildUsers() => StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8),
      itemCount: users.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
      final user = users[index];
      return UserCardWidget(user: user, index: index);
      },
    );  
}

