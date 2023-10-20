// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/nawqes.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
// import '../../controllers/database_controller.dart';
// import '../../models/offer_model.dart';

class NawaqestDetails extends StatelessWidget {
  final ShowingNawaqesModel nawaqes;
  const NawaqestDetails({
    Key? key,
    required this.nawaqes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference actorOffers =
        FirebaseFirestore.instance.collection('actorsOffers');

//  Stream<List<OfferModel>>offerModel = database.actorsOffersStream() ;
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'اسم المندوب ${nawaqes.actorName}',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              // _docReference.delete();
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

          Text('  اسم الصنف ${nawaqes.title}',
              style: Theme.of(context).textTheme.headlineSmall),
          Text(' السعر ${nawaqes.price}',
              style: Theme.of(context).textTheme.titleLarge),
          // const Divider(
          //   height: 1.0,
          // ),
          ListTile(
            leading: const Icon(Icons.description),
            title: Text(
              "اسم العميل ${nawaqes.description}",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
            trailing: Text(
              " ${nawaqes.ammount.toString()} الكمية",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black54,
                  ),
            ),
          ),

          Expanded(
                child: SizedBox(
                  width: double.infinity ,
                  child: StreamBuilder(
                  stream: actorOffers.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  
                    return Align(
                      alignment: Alignment.centerRight,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!.docs.map((data) {
                            // itemCount: snapshot.data!.docs.length,
                            return Column(children: [
                              // ListTile(
                              //   shape: RoundedRectangleBorder(
                              //     side: const BorderSide(width: 2),
                              //     borderRadius: BorderRadius.circular(20),
                              //   ),
                    
                              Card(
                                child:  Text(
                                  " ${data['offeringPrice']}".toString(),
                                  style: const TextStyle(color: Colors.black),
                                  
                                ),
                              ),
                             Text(
                                  " ${data['customerName']}",
                                  
                                ),
                                
                                                              
                              Card(child: Text(" ${data['actorName']}")),
                    
                              Card(
                                child: Text(
                                  " ${data['requiestAmmount']}".toString(),
                                ),
                              ),
                            ]);
                          }).toList()),
                    );
                  }),
                ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.addOfferRout);
          },
          child: const Icon(Icons.add)),
    );
  }
}

// StreamBuilder<List<OfferModel>>(
//     stream: database.actorsOffersStream(),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.active) {
//         final actorsoffer = snapshot.data;
//         if (actorsoffer == null || actorsoffer.isEmpty) {
//           return const Center(
//             child: Text('No Data Available!'),
//           );
//         }
//         return ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: actorsoffer.length,
//           itemBuilder: (_, int index) => Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListTile(
//               shape: RoundedRectangleBorder(
//                 side: const BorderSide(width: 2),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               leading: CircleAvatar(
//                 backgroundColor:
//                     const Color.fromARGB(255, 43, 179, 221),
//                 child: Text(
//                   offerModel[].toString(),
//                   style: const TextStyle(color: Colors.black),
//                 ),
//               ),
//               title: Text(
//                 actorsoffer.,
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleLarge!
//                     .copyWith(
//                       fontWeight: FontWeight.w600,
//                     ),
//               ),
//               subtitle: Text('${offerModel.requiestAmmount}'),
//               // trailing: Text('${widget.nawaqes.price}'),
//               trailing: Text(offerModel.actorName),
//             ),
//           ),
//         );
//       }
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }),
//************************************************* */
// Future<void> _addToCart(Database database) async {
//   try {
//     final addToCartProduct = AddToCartModel(
//       id: documentIdFromLocalData(),
//       title: widget.nawaqes.title,
//       price: widget.nawaqes.price,
//       productId: widget.nawaqes.id,
//       imgUrl: widget.nawaqes.imgUrl,
//       size: dropdownValue,
//     );
//     await database.addToCart(addToCartProduct);
//   } catch (e) {
//     return MainDialog(
//       context: context,
//       title: 'Error',
//       content: 'Couldn\'t adding to the cart, please try again!',
//     ).showAlertDialog();
//   }
// }

// Image.network(
//   widget.nawaqes.imgUrl,
//   width: double.infinity,
//   height: size.height * 0.55,
//   fit: BoxFit.cover,
// ),
// const SizedBox(height: 8.0),
// Padding(
//   padding: const EdgeInsets.symmetric(
//     horizontal: 16.0,
//     vertical: 8.0,
//   ),
//   child: Container(
//     decoration: BoxDecoration(
//       border: Border.all(),
//     ), // border making ,
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '\$${nawaqes.price}',
//                 style:
//                     Theme.of(context).textTheme.headlineSmall!.copyWith(
//                           fontWeight: FontWeight.w600,
//                         ),
//               ),
//               Text(
//                 nawaqes.title,
//                 style:
//                     Theme.of(context).textTheme.headlineSmall!.copyWith(
//                           fontWeight: FontWeight.w600,
//                         ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 " ${nawaqes.ammount.toString()} الكمية",
//                 style:
//                     Theme.of(context).textTheme.titleMedium!.copyWith(
//                           color: Colors.black54,
//                         ),
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Text(
//                   'اسم المندوب ${nawaqes.actorName}',
//                   style:
//                       Theme.of(context).textTheme.titleSmall!.copyWith(
//                             fontWeight: FontWeight.w600,
//                           ),
//                 ),
//               ),
//               const SizedBox(height: 8.0),
//             ],
//           ),
//           const SizedBox(height: 16.0),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Text(
//               "اسم العميل ${nawaqes.description}",
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//           ),
//           const SizedBox(height: 32.0),
//         ],
//       ),
//     ),
//   ),
// ),
// const SizedBox(
//   height: 24,
// ),
//   //-------------------------------------------------------------
//
