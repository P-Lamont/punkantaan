import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:punkantaan/song_model.dart';

class RiverpodModel extends ChangeNotifier{
  List<SongModel>? songcontents;
  int? songIndex;
  double titleFontSize=20;
  double bodyFontSize=18;
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
  void setTitleSize(double data){
    titleFontSize =data;
    notifyListeners();
  }
  void setBodySize(double data){
    bodyFontSize =data;
    notifyListeners();
  }
  void setHighlighted(Map<String,dynamic>? data){
    highlighted=data;
    notifyListeners();
  }
}