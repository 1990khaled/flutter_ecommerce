import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/auth_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/database_controller.dart';
import '../../models/user_data.dart';
import '../widgets/list_profile_info.dart';
import '../widgets/main_button.dart';
import '../widgets/snacks_bar.dart';
import 'edit_user_information.dart';
import 'user_orders.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _logout(AuthController model, context) async {
    try {
      await model.logout();
      Navigator.pop(context);
    } catch (e) {
      debugPrint('logout error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // int timeDuration = 20;

    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    late List<UserModel?> user;
    // Changed UserModel to UserModel?
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.06,
              left: size.height * 0.02,
              right: size.height * 0.02),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.70,
                child: StreamBuilder<List<UserModel>>(
                  stream: database.getUserInformationStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData && snapshot.data != null) {
                        user = snapshot.data!;
                        if (user.isNotEmpty) {
                          return ListProfileInfo(
                            userModel: user[0]!,
                          );
                        } else {
                          return const Center(
                              child: Text("من فضلك ادخل بياناتك"));
                        }
                      } else {
                        return const Center(
                            child: Text("من فضلك ادخل بياناتك"));
                      }
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2));
                    }
                  },
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const EditUserInformation(),
                      ));
                    },
                    child: const Text(
                      "تعديل بياناتي",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _launchURL();
                    },
                    child: const Text(
                      "تواصل معنا ",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (
                          user.isNotEmpty) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UserOrderPage(
                              companyName: user[0]!.companyName,
                              phoneNum:
                                  user[0]!.phoneNum, // Ensure null safety here
                            ),
                          ),
                        );
                      } else {
                        showSnackbar(context, 'لا يوجد اي طلبيات حاليا');
                      }
                    },
                    child: const Text(
                      "طلبيـــــاتـي",
                    ),
                  ),
                ],
              ),
              Consumer<AuthController>(
                builder: (_, model, __) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: MainButton(
                        text: 'خروج من الحساب',
                        onTap: () {
                          _logout(model, context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future _launchURL() async {
  String facebookUrl =
      "https://www.facebook.com/profile.php?id=61554534424647&mibextid=ZbWKwL";
  Uri url = Uri.parse(facebookUrl);
  if (await launchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
