import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/auth_controller.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/user_modle.dart';
import '../widgets/list_profile_info.dart';
import 'editing/my_special_button.dart';
import 'user_orders.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
    // var specialController = Provider.of<SpecialController>(context);
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            // alignment: Alignment.bottomRight,
            children: [
              Image.asset(
                "assets/images/profile-background.png",
                width: double.infinity,
                height: size.height * 0.27,
                fit: BoxFit.cover,
              ),
              Opacity(
                opacity: 0.1,
                child: Container(
                  width: double.infinity,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.5),
          SizedBox(
            height: size.height * 0.75,
            child: StreamBuilder<List<UserModle>>(
                stream: database.profileInfoStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final userInfo = snapshot.data;
                    if (userInfo == null || userInfo.isEmpty) {
                      return const Center(
                        child: Text("من فضلك ادخل بياناتك"),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: userInfo.length,
                      itemBuilder: (_, int index) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListProfileInfo(
                          userModle: userInfo[index],
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          Positioned(
            bottom: size.height * 0.34,
            right: size.height * 0.14,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const UserOrderPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "طلبياتي",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        //TODO: Add logic for editing user information
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: size.height * 0.20,
            right: size.height * 0.17,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 2,
                    ),
                  ),

                  //TODO make the add button showing only to my two users
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const MySpecialButtonWidget()));
                      },
                      icon: const Icon(Icons.add))),
            ),
          ),
          Consumer<AuthController>(
            builder: (_, model, __) => Column(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20),
                  child: MainButton(
                      text: 'Log Out',
                      onTap: () {
                        _logout(model, context);
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
