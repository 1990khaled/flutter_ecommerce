import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/news_modle.dart';
import 'package:flutter_ecommerce/views/widgets/header_of_list.dart';
import 'package:flutter_ecommerce/views/widgets/list_item_home.dart';
import 'package:provider/provider.dart';
import '../../models/new_product.dart';
import '../widgets/list_item_news.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Image.asset(
                  "assets/images/al-yassin-company.png",
                  width: double.infinity,
                  height: size.height * 0.27,
                  fit: BoxFit.cover,
                ),
                Opacity(
                  opacity: 0.1,
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.3,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 16.0,
                  ),
                  child: Text(
                    'جميع الاسعار جملة فقط',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: const Color.fromARGB(255, 196, 201, 196),
                          // fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const HeaderOfList(
                      title: 'صفقات واخبار عن سوق الالومنيوم',
                      description: 'اهم الاخبار',
                    ),
                    const SizedBox(height: 7.0),
                    SizedBox(
                      height: size.height * 0.23,
                      child: StreamBuilder<List<NewsModel>>(
                          stream: database.newsStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              final news = snapshot.data;
                              if (news == null || news.isEmpty) {
                                return const Center(
                                  child: Text('لا يوجد بيانات'),
                                );
                              }
                              return GridView.count(
                                  scrollDirection: Axis.horizontal,
                                  crossAxisCount: 1,
                                  children: List.generate(
                                    news.length,
                                    (index) {
                                      return Center(
                                        child: ListItemNews(
                                          newsModel: news[index],
                                        ),
                                      );
                                    },
                                  ));
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const HeaderOfList(
                    title: 'عروض الفترة الحالية',
                    description: 'عروض',
                  ),
                  const SizedBox(height: 1.0),
                  SizedBox(
                    height: size.height * 0.4,
                    child: StreamBuilder<List<NewProduct>>(
                        stream: database.newProductsStream(),
                        builder: (context, snapshot) {
                          //         if (snapshot.hasError) {
                          //   return  Center(
                          //     child: Text('${snapshot.error}'),
                          //   );
                          // }
                          // if (snapshot.connectionState == ConnectionState.done) {
                          //   return const Center(
                          //     child: Text('ان شاء الله خير'),
                          //   );
                          // }
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            final newProduct = snapshot.data;
                            if (newProduct == null || newProduct.isEmpty) {
                              return const Center(
                                child: Text('لا يوجد بيانات'),
                              );
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: newProduct.length,
                              itemBuilder: (_, int index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListItemHome(
                                  newProduct: newProduct[index],
                                ),
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
