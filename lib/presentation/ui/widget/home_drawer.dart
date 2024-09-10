import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/data/utility/auth_utility.dart';
import 'package:my_notes/presentation/ui/screen/add_new_note_screen.dart';
import 'package:my_notes/presentation/ui/utility/style.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              padding: const EdgeInsets.all(0),
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.amber),
                accountName: Text(
                  '${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}',
                  style: Head6Text(colorDarkBlue),
                ),
                accountEmail: Text(
                  AuthUtility.userInfo.data?.email ?? 'Unknown',
                  style: Head7Text(colorDarkBlue),
                ),
                currentAccountPicture: Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/2048px-Circle-icons-profile.svg.png"),
              )),
          ListTile(
            leading: const Icon(
              Icons.add,
              color: colorDarkBlue,
            ),
            title: Text(
              'Add a New Note',
              style: Head6Text(colorDarkBlue),
            ),
            onTap: () {
              Get.to(const AddNewNoteScreen());
            },
          ),
        ],
      ),
    );
  }
}
