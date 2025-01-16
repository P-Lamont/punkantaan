import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:punkantaan/song_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RiverpodModel extends ChangeNotifier{
  List<SongModel>? songcontents;
  int? songIndex;
  double titleFontSize=20;
  double bodyFontSize=18;
  Color highlightColor = Colors.yellow.shade400;
  Map<String,dynamic>? highlighted;
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/songs.json');
    final data = await json.decode(response);
    List<dynamic> contents =data['contents'];
    songcontents= contents.map((e) => SongModel.fromJson(e)).toList();      
    notifyListeners();
  }
  void setSongIndex(int data){
    songIndex =data;
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
  }
  void setDefaultSettings(){
    setTitleSize(20);
    setBodySize(18);
    changeColorHighlight(Colors.yellow.shade400);
  }
}