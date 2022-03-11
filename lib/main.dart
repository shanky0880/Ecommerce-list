import 'package:flutter/material.dart';
import 'package:http_api_call/Homepage.dart';
import 'package:http_api_call/change_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers: [ChangeNotifierProvider<Apicall>(create: (context) => Apicall(),)],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
         
          primarySwatch: Colors.blue,
        ),
        home:  Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

