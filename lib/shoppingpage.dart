import 'package:flutter/material.dart';
import 'package:http_api_call/change_notifier.dart';
import 'package:http_api_call/productmodel.dart';
import 'package:provider/provider.dart';

class Shoppingpage extends StatelessWidget {
  const Shoppingpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Product> itemdata = context.watch<Apicall>().shoppinglist;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wish List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        //centerTitle: true,
        backgroundColor: Colors.cyan,
        elevation: 0,
        // leading: Icon(Icons.shop),

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(
              Icons.storefront,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: itemdata.length,
                itemBuilder: (context, index) {
                  var displayitem = itemdata[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      title: Text(displayitem.title),
                      subtitle: Column(
                        children: [
                          Container(
                            height: 40,
                            width: 230,
                            //   color: Colors.green,
                            child: Text(
                              displayitem.description,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Container(
                                  // color: Colors.blue,
                                  width: 80,
                                  child: Text(
                                    "Rs " + displayitem.price.toString(),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      leading: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 54,
                          minHeight: 54,
                          maxWidth: 54,
                          maxHeight: 64,
                        ),
                        child: Image.network(
                          displayitem.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
