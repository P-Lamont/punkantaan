import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:punkantaan/model/contents_riverpod.dart';
import 'package:punkantaan/model/song_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'model_riverpod.g.dart';

@Riverpod(keepAlive:true)
class ModelRiverpod extends _$ModelRiverpod{
  @override
  ContentsRiverpod build(){
    return ContentsRiverpod(
      titleFontSize:20,bodyFontSize:18,highlightColor:Colors.yellow.shade400,
      favorites:[],recent:[]
    );
  }
  Future<void> addtoFavorites(int data)async{
    List<int> newFavorites = state.favorites+[data];
    newFavorites.sort();
    state = state.copyWith(favorites:newFavorites);
    // state = state.copyWith(favorites:[...state.favorites]..sort());
    List<String> favoritesData = newFavorites.map((data)=> data.toString()).toList();
    await savePreference('favorites',favoritesData);
  }
  Future<void> removeFavorites(int data)async{
    List<int> newFavorites = List<int>.from(state.favorites)..remove(data);
    state = state.copyWith(favorites:newFavorites);
    // favorites.remove(data);
    List<String> favoritesData = newFavorites.map((data)=> data.toString()).toList();
    await savePreference('favorites',favoritesData);

  }
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/songs.json');
    final data = await json.decode(response);
    List<dynamic> contents =data['contents'];
    List<SongModel>songcontents= contents.map((e) => SongModel.fromJson(e)).toList();      
    state = state.copyWith(songcontents: songcontents);
  }
  Future<void> setSongIndex(int data)async{
    state = state.copyWith(songIndex: data);
    // songIndex =data;
    await saveRecent(data+1);

  }
  Future<void> setTitleSize(double data)async{
    state = state.copyWith(titleFontSize: data);
    // titleFontSize =data;
    await savePreference('titleFontSize',data);

  }
  Future<void> setBodySize(double data)async{
    state = state.copyWith(bodyFontSize: data);
    // bodyFontSize =data;
    await savePreference('bodyFontSize',data);

  }
  void setHighlighted(Map<String,dynamic>? data){
    state = state.copyWith(highlighted: data);
    // highlighted=data;

  }
  Future<void> changeColorHighlight(Color data)async{
    state = state.copyWith(highlightColor: data);
    // highlightColor = data;
    await savePreference('HRed',data.red);
    await savePreference('HGreen',data.green);
    await savePreference('HBlue',data.blue);
    await savePreference('HAlpha',data.alpha);

  }
  Future<void> initPreference()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double? titleSize = prefs.getDouble('titleFontSize');
    final double? bodyFontSize = prefs.getDouble('bodyFontSize');
    final int? hRed = prefs.getInt('HRed');
    final int? hGreen = prefs.getInt('HGreen');
    final int? hBlue = prefs.getInt('HBlue');
    final int? hAlpha = prefs.getInt('HAlpha');
    final favoritesString = prefs.getStringList('favorites');
    if (favoritesString!=null){
      state = state.copyWith(
        favorites:favoritesString.map((element)=> int.parse(element)).toList()
      );
      // favorites = favoritesString.map((element)=> int.parse(element)).toList();
    }
    final recentString = prefs.getStringList('recent');
    if (recentString!=null){
      state = state.copyWith(
        recent:recentString.map((element)=> int.parse(element)).toList()
      );
      // recent = recentString.map((element)=> int.parse(element)).toList();
    }
    if (titleSize!=null){
      setTitleSize(titleSize);
    } 
    if (bodyFontSize!=null){
      setBodySize(bodyFontSize);
    }
    if( hRed != null && hGreen != null && hBlue != null && hAlpha != null){
      changeColorHighlight(Color.fromARGB(hAlpha, hRed, hGreen, hBlue));
    }
  }
  Future<void> savePreference(String title, dynamic data) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (data is int){
      await prefs.setInt(title, data);
    }
    if (data is double){
      await prefs.setDouble(title, data);
    }
    if (data is bool){
      await prefs.setBool(title, data);
    }
    if (data is String){
      await prefs.setString(title, data);
    }
    if (data is List<String>){
      await prefs.setStringList(title, data);
    }
  }
  void setDefaultSettings(){
    setTitleSize(20);
    setBodySize(18);
    changeColorHighlight(Colors.yellow.shade400);
  }
  Future<void> saveRecent(int data)async{
    if (state.recent.contains(data)){
      state = state.copyWith(recent:state.recent..remove(data));
      // recent.remove(data);
    }
    state = state.copyWith(recent:state.recent..insert(0,data));
    // recent.insert(0,data);
    if (state.recent.length>10){
      // recent.removeLast();
      state = state.copyWith(recent:state.recent..removeLast());
    }
    List<String> recentData = state.recent.map((data)=> data.toString()).toList();
    await savePreference('recent',recentData);    
  }

}