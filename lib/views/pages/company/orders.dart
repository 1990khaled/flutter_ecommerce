import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/orders_model.dart';
import 'package:provider/provider.dart';
import '../../widgets/orders_info_list_item.dart';

class AllOrdersPage extends StatefulWidget {
  
  const AllOrdersPage({Key? key}) : super(key: key);

  @override
  State<AllOrdersPage> createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  TextEditingController searchController = TextEditingController();
  String value = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    bool isSearching = false;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(),
        title: TextField(
          textAlign: TextAlign.end,
          controller: searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: 'بحث...',
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Colors.white),
              onPressed: () {
                setState(() {
                  searchController.clear();
                  FocusScope.of(context).unfocus();
                  value = "";
                });
              },
            ),
          ),
          onChanged: (newValue) async {
            setState(() {
              if (newValue.isNotEmpty) {
                isSearching = true;
                value = newValue;
              }
            });
          },
        ),
      ),
      body: Stack(children: [
        if (isSearching = true)
          Visibility(
            visible: isSearching,
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 8, left: 10, right: 10, top: 35),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: size.height * 0.75,
                        child: StreamBuilder<List<OrdersModel>>(
                            stream: database.myOrdersStream(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                final products = snapshot.data
                                    ?.where((element) => element.customerName
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                                // debugPrint("${snapshot.error} ----------------------");
                                if (products == null || products.isEmpty) {
                                 
                                  return const Center(
                                    child: Text("مشاكل بالاتصال")
                                  );
                                }

                                return Builder(builder: (context) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: products.length,
                                    itemBuilder: (_, int index) => Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: OrdersInfoListTime(
                                        ordersModel: products[index],
                                      ),
                                    ),
                                  );
                                });
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      ),
                    ]),
              ),
            )),
          ),
      ]),
    );
  }
}
