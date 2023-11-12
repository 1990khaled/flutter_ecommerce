// import 'package:flutter/material.dart';

// class FavouriteListItem extends StatelessWidget {
//   const FavouriteListItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
//    shrinkWrap: true,
//    itemCount: products.length,
//    itemBuilder: (context, index) {
//      return Card(
//        color: Colors.blueGrey.shade200,
//        elevation: 5.0,
//        child: Padding(
//          padding: const EdgeInsets.all(4.0),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            mainAxisSize: MainAxisSize.max,
//            children: [
//              Image(
//                height: 80,
//                width: 80,
//                image: AssetImage(products[index].image.toString()),
//              ),
//              SizedBox(
//                width: 130,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                    const SizedBox(
//                      height: 5.0,
//                    ),
//                    RichText(
//                      overflow: TextOverflow.ellipsis,
//                      maxLines: 1,
//                      text: TextSpan(
//                          text: 'Name: ',
//                          style: TextStyle(
//                              color: Colors.blueGrey.shade800,
//                              fontSize: 16.0),
//                          children: [
//                            TextSpan(
//                                text:
//                                    '${products[index].name.toString()}\n',
//                                style: const TextStyle(
//                                    fontWeight: FontWeight.bold)),
//                          ]),
//                    ),
//                    RichText(
//                      maxLines: 1,
//                      text: TextSpan(
//                          text: 'Unit: ',
//                          style: TextStyle(
//                              color: Colors.blueGrey.shade800,
//                              fontSize: 16.0),
//                          children: [
//                            TextSpan(
//                                text:
//                                    '${products[index].unit.toString()}\n',
//                                style: const TextStyle(
//                                    fontWeight: FontWeight.bold)),
//                          ]),
//                    ),
//                    RichText(
//                      maxLines: 1,
//                      text: TextSpan(
//                          text: 'Price: ' r"$",
//                          style: TextStyle(
//                              color: Colors.blueGrey.shade800,
//                              fontSize: 16.0),
//                          children: [
//                            TextSpan(
//                                text:
//                                    '${products[index].price.toString()}\n',
//                                style: const TextStyle(
//                                    fontWeight: FontWeight.bold)),
//                          ]),
//                    ),
//                  ],
//                ),
//              ),
//              ElevatedButton(
//                  style: ElevatedButton.styleFrom(
//                      primary: Colors.blueGrey.shade900),
//                  onPressed: () {
//                    saveData(index);
//                  },
//                  child: const Text('Add to Cart')),
//            ],
//          ),
//        ),
//      );
//   }
// }



//----------------------------
// class ItemInCart extends StatefulWidget {
//   @override
//   State<ItemInCart> createState() => _ItemInCartState();
// }

// class _ItemInCartState extends State<ItemInCart> {
//   @override
//   Widget build(BuildContext context) {
// int qunatity = 1;
//     return Column(children: [
// Row(
//   mainAxisAlignment:MainAxisAlignment.spaceBetween ,
//   children: [
// ClipRRect(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(16.0),
//               bottomLeft: Radius.circular(16.0),
//             ),
//             child: Image.network(
//               widget.cartItem.imgUrl,
//               fit: BoxFit.cover,
//             ),
//           ),
//   Container(
//     height: 4.0,
//     width: 4.0,
//           decoration: BoxDecoration(
//     border: Border.all(
//       color: Colors.black,),),
//             child: Text ("${widget.cartItem.qunInCarton} العدد"),
//            ),
//           Text(
//             widget.cartItem.title,
//             style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//           ), 
// ],),
// ListTile(
//   title:  ,
//   subtitle: ,
//   leading: Row(
//     children: [
//       const Text ("الكمية"), 
//       Column(
//             children:[
              
//                IconButton(icon: const Icon(Icons.arrow_upward),

//                onPressed: (){
//                 setState(() {
//                   qunatity++;
//                 });
//                } ),
//                Container(
//               decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black,),),
//                 child: Text ("$qunatity"),
//                ),
//                IconButton(icon: const Icon(Icons.arrow_drop_down),

//                onPressed: (){
//                 setState(() {
//                   qunatity--;
//                 });
//                } ),
              
//             ],
//           ),
//     ],
//   ), 
//   trailing: IconButton(onPressed: (){}, icon:const Icon(Icons.delete)),
// )

//     ]);
//   }
// }