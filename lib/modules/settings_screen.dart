import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView.separated(
        itemBuilder: (ctx, index) {
          return buildSettingsItems(
            items: [
              "My List",
              "App Settings",
              "Feedback",
              "About App"
            ],
            icons: [
              Icons.menu,
              Icons.settings,
              Icons.feedback,
              Icons.info,
            ],
            index: index,
          );
        },
        separatorBuilder: (ctx, index) {
          return Container(
            color: Colors.white,
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 10),
          );
        },
        itemCount: 4,
      ),
    );
  }
}

Widget buildSettingsItems({required List<String> items,required int index,required List<IconData> icons}) => ListTile(
      leading: Icon(
        icons[index],
        color: Colors.white,
      ),
      title: Text(
        items[index],
        style: const TextStyle(color: Colors.white),
      ),
    );
