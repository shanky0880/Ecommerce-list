import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_api_call/change_notifier.dart';
import 'package:http_api_call/productmodel.dart';
import 'package:http_api_call/shoppingpage.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final itemdata = context.watch<Apicall>().shoppinglist;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        //centerTitle: true,
        backgroundColor: Colors.cyan,
        elevation: 0,
        // leading: Icon(Icons.shop),

        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(
              Icons.storefront,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Badge(
              badgeContent: Text(itemdata.length.toString()),
              position: BadgePosition.topEnd(top: 2, end: 4),
              animationType: BadgeAnimationType.fade,
              child: IconButton(
                icon: Icon(Icons.add_shopping_cart),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Shoppingpage()));
                },
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: context.read<Apicall>().getHttp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var iteam = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.only(
                        right: 18.0, top: 12.0, bottom: 12.0),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Container(
                          //  color: Colors.pink,
                          height: 25,
                          width: 230,
                          child: Text(
                            iteam.title,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Container(
                            height: 40,
                            width: 230,
                            //   color: Colors.green,
                            child: Text(
                              iteam.description,
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
                                  child: Container(
                                    height: 20,
                                    // color: Colors.yellow,
                                    child: Text(
                                      "Rs " + iteam.price.toString(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          'Item Successfully Added',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.green,
                                      ));
                                      context.read<Apicall>().addtoshop(iteam);
                                    },
                                    child: const Text(
                                      'Buy now',
                                      style: TextStyle(fontSize: 13),
                                    ))
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
                          iteam.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
