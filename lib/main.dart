
import 'package:punkantaan/model/model_riverpod.dart';
import 'package:punkantaan/view/chapters_page.dart';
import 'package:punkantaan/view/home_page.dart';
import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:punkantaan/view/favorites_page.dart';
import 'package:punkantaan/view/reading.dart';
import 'package:punkantaan/view/recents_page.dart';
import 'package:punkantaan/view/search_page.dart';
import 'package:punkantaan/view/settings_page.dart';
import 'package:punkantaan/view/list_books_page.dart';
// import 'package:punkantaan/song_model.dart';

void main() {
  runApp(const ProviderScope(child:MyApp()));

}

// final riverpodProvider = ChangeNotifierProvider<RiverpodModel>((ref){
//   return RiverpodModel();
// }); 

class MyApp extends ConsumerWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context,WidgetRef ref){
    final appStateN = ref.watch(modelRiverpodProvider.notifier);
    // final appState = ref.watch(modelRiverpodProvider);
    appStateN.initPreference();
    appStateN.readJson();
    // bool hasContents = appState.songcontents==null;
    return MaterialApp(
      title: 'Punkantaan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: hasContents?const CircularProgressIndicator():const MyHomePage(),
      initialRoute: '/home',
      routes:{
        '/home':(context)=> const MyHomePage(),
        '/fav':(context)=> const FavoritesPage(),
        '/rec':(context)=> const RecentsPage(),
        '/search':(context)=> const SearchResultView(),
        '/settings':(context)=> const SettingsPage(),
        '/listbooks':(context)=> const ListBooksPage(),
        '/chapter':(context)=> const ChaptersPage(),
        '/reading':(context)=> const ReadingPage(),
      }
      // routes: ,
    );
  }

}

