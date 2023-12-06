import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/user_data.dart';
import '../widgets/list_profile_info.dart';
import '../widgets/main_button.dart';
import 'edit_user_information.dart';
import 'user_orders.dart';

class ProfilePage extends StatelessWidget {
  late UserModel user;
   ProfilePage({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.70,
                child: FutureBuilder<UserModel?>(
                  future: database.getUserInformation(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      final userModel = snapshot.data!;
                    user = userModel;
                      return ListProfileInfo(userModel: userModel);
                    }
                    if (snapshot.data == null) {
                      return const Center(child: Text("من فضلك أدخل بياناتك"));
                    } else {
                      return const Center(child: CircularProgressIndicator());
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const EditUserInformation(),
                        ),
                      );
                    },
                    child: const Text(
                      "تعديل بياناتي",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              UserOrderPage(customerName: user.name),
                        ),
                      );
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
                    // const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20),
                      child: SmallMainButton(
                          text: 'خروج من الحساب',
                          onTap: () {
                            _logout(model, context);
                          }),
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
