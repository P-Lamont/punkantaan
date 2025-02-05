import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:punkantaan/model/song_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RiverpodModel extends ChangeNotifier{
  List<SongModel>? songcontents;
  int? songIndex;
  double titleFontSize=20;
  double bodyFontSize=18;
  Color highlightColor = Colors.yellow.shade400;
  Map<String,dynamic>? highlighted;
  List<int> favorites =[];
  List<int> recent =[];
  Future<void> addtoFavorites(int data)async{
    favorites.add(data);
    favorites.sort();
    List<String> favoritesData = favorites.map((data)=> data.toString()).toList();
    await savePreference('favorites',favoritesData);
    notifyListeners();    
  }
  Future<void> removeFavorites(int data)async{
    favorites.remove(data);
    List<String> favoritesData = favorites.map((data)=> data.toString()).toList();
    await savePreference('favorites',favoritesData);
    notifyListeners();    
  }
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/songs.json');
    final data = await json.decode(response);
    List<dynamic> contents =data['contents'];
    songcontents= contents.map((e) => SongModel.fromJson(e)).toList();      
    notifyListeners();
  }
  Future<void> setSongIndex(int data)async{
    songIndex =data;
    await saveRecent(data+1);
    notifyListeners();
  }
  Future<void> setTitleSize(double data)async{
    titleFontSize =data;
    await savePreference('titleFontSize',data);
    notifyListeners();
  }
  Future<void> setBodySize(double data)async{
    bodyFontSize =data;
    await savePreference('bodyFontSize',data);
    notifyListeners();
  }
  void setHighlighted(Map<String,dynamic>? data){
    highlighted=data;
    notifyListeners();
  }
  Future<void> changeColorHighlight(Color data)async{
    highlightColor = data;
    await savePreference('HRed',data.red);
    await savePreference('HGreen',data.green);
    await savePreference('HBlue',data.blue);
    await savePreference('HAlpha',data.alpha);
    notifyListeners();
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
      favorites = favoritesString.map((element)=> int.parse(element)).toList();
    }
    final recentString = prefs.getStringList('recent');
    if (recentString!=null){
      recent = recentString.map((element)=> int.parse(element)).toList();
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
    if (recent.contains(data)){
      recent.remove(data);
    }
    recent.insert(0,data);
    if (recent.length>10){
      recent.removeLast();
    }
    List<String> recentData = recent.map((data)=> data.toString()).toList();
    print('recents $data');
    await savePreference('favorites',recentData);    
  }
}