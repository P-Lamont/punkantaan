import 'package:flutter/material.dart';
// import 'package:komyuter/main.dart';
// import 'package:komyuter/model/dialog.dart';
import 'dart:async' show Future;
// import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:punkantaan/dialog.dart';
// import 'package:provider/provider.dart';
// import 'package:komyuter/model/profile_provider.dart';
class AppLicensePage extends StatefulWidget {
  const AppLicensePage({super.key});

  @override
  State<AppLicensePage> createState() => _AppLicensePageState();
}

class _AppLicensePageState extends State<AppLicensePage> {
  Future<String> loadLicense(BuildContext context,String name) async {
    return await DefaultAssetBundle.of(context).loadString('$name.txt');
  }
  Future<String> loadJson(String data) async {
    return await rootBundle.loadString('$data.json');
  }
  Future<String> _loadTextFromAsset() async {
    String text =''; 
    try {
      text= await loadJson("assets/license_folder/licenses");
    } catch (e) {
      if (mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
        );
      }
    }
    return text;
  }
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: FutureBuilder<String>(
        future: _loadTextFromAsset(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView(
              children: _buildLicenseFile(snapshot.data)
            );
          }
          return const Center(child: CircularProgressIndicator());
        }
      )
    );
  }
  List<ListTile> _buildLicenseFile(String? licenses){
    // final profileProvider = Provider.of<ProfileProvider>(context);
    List<ListTile> data = [];
    if (licenses==null || licenses==''){
      return data;
    }
    Map<String, dynamic> parsedJson = jsonDecode(licenses);
    parsedJson['licenses']?.map((item)=>{
      data.add( 
        ListTile(
          title:  Text(item),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap:()async{
            String data = await loadLicense(
              context,"assets/license_folder/${item.toString().replaceAll(RegExp(r' '), '_')}"
            );
            if (mounted){
              showAlertDialog(context, data, '${item.toString().toUpperCase()} LICENSE');
            }
          }
        )
      )
    }).toList();
    return data;
  }
}