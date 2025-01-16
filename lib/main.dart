
import 'package:punkantaan/home_page.dart';
import 'package:punkantaan/riverpod_model.dart';
import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// import 'package:punkantaan/song_model.dart';

void main() {
  runApp(const ProviderScope(child:MyApp()));

}

final riverpodProvider = ChangeNotifierProvider<RiverpodModel>((ref){
  return RiverpodModel();
}); 

class MyApp extends ConsumerWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context,WidgetRef ref){
    final appState = ref.watch(riverpodProvider);
    appState.initPreference();
    appState.readJson();
    bool hasContents = appState.songcontents==null;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: hasContents?const CircularProgressIndicator():const MyHomePage(),
      // routes: ,
    );
  }

}

