import 'package:flutter/material.dart';
import 'package:money_map/common/constants/widgets/primary_button.dart';
import 'package:money_map/locator.dart';
import 'package:money_map/services/auth_service.dart';
import 'package:money_map/services/secure_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile'),
            PrimaryButton(
              text: "Logout",
              onPressed: () async {
                await locator.get<AuthService>().signOut();
                await const SecureStorage().deleteAll();
                if (!context.mounted) return;
                {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
