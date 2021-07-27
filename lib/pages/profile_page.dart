import 'package:flutter/material.dart';
import 'package:gtc_app/models/student.dart';
import 'package:gtc_app/widgets/appbar_widget.dart';
import 'package:gtc_app/widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  final Student student;

  const ProfilePage({required this.student});


  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileWidget(
            imagePath: widget.student.image!,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(widget.student),
          const SizedBox(height: 200),
        ],
      ),
    );
  }

  Widget buildName(Student user) => Column(
    children: [
      Text(
        user.name!,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user.address!,
        style: TextStyle(color: Colors.grey[600]),
      ),
      const SizedBox(height: 4),
      Text(
        user.phone!,
        style: TextStyle(color: Colors.grey[600]),
      )
    ],
  );
}
