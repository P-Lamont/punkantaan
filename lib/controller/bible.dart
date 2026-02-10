import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:punkantaan/model/bible_model.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'bible.g.dart';
@Riverpod(keepAlive:true)
class BibleNotifier extends _$BibleNotifier{
  @override
  BibleModel build() {
    return BibleModel();
  }
  Future<void> listBooks() async {
    final newTest = await getAssetFolders('new_testament');
    final oldTest = await getAssetFolders('old_testament');

    List<String> allbooks =[...oldTest,...newTest];
    allbooks.map((e)=>e.substring(e.lastIndexOf('_')+1)).toList();

    state = state.copyWith(books:allbooks);
  }

  Future<void> loadAssetsFromFolder(String folder) async {

    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    // Filter only the assets in the given folder
    final assets = manifestMap.keys
        .where((String key) => key.contains(folder))
        .toList();
    state = state.copyWith(chapters:assets);
    // return assets;
  }

  Future<List<String>> getAssetFolders(String folder) async {
    // Load Flutter's generated asset manifest
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // print(manifestMap.keys);
    // Extract folder paths
    final assetPaths = manifestMap.keys
      .where((String key) => key.contains(folder))
      .toList();
    // print(assetPaths);
    final folders = assetPaths
      .map((path) {
        // remove the file name, keep only the folder part
        final parts = path.split('/');
        if (parts.length > 1) {
          // parts.removeLast(); // remove file name
          // return parts[2];
          final bookName = parts[2];
          return bookName.split('_')[1];
        }
        return '';
      })
      .where((f) => f.isNotEmpty)
      .toSet()
      .toList();
      // print(folders);
    return folders;
  }
  
  void prevAudio(){
    if (state.currentBookIndex!=null && state.currentChapterIndex!=null){
      if (state.currentChapterIndex!=1){
        state = state.copyWith(currentChapterIndex: state.currentChapterIndex!-1);
      }else if(state.currentChapterIndex==1 && state.currentBookIndex!=1){
        final newBook =state.books![state.currentBookIndex!-1];
        state =state.copyWith(
          currentBookIndex: state.currentBookIndex!-1,
          currentChapterIndex: state.bibleSummary![newBook],
          book: newBook
        );
      }
      //add to previous book
    }
  }
  
  void nextAudio(){
    if (state.currentBookIndex!=null && state.currentChapterIndex!=null){
      final book = state.bibleSummary?.keys.toList()[state.currentBookIndex!];
      if(state.currentChapterIndex==state.bibleSummary![book] && state.currentBookIndex!=state.bibleSummary!.length){
        state =state.copyWith(
          currentBookIndex: state.currentBookIndex!+1,
          currentChapterIndex:1
        );
      }else if (state.currentChapterIndex!=1){
        state = state.copyWith(currentChapterIndex: state.currentChapterIndex!+1);
      }
    }
  }
  
  void setBookIndex(int index){
    state = state.copyWith(currentBookIndex: index);
  }
  
  void setChapterIndex(int index){
    state = state.copyWith(currentChapterIndex: index);
  }
  
  void setIsPlaying(bool data){
    state = state.copyWith(isPlaying: data);
  }
  
  void playAudio(){
    state.player?.play();
    setIsPlaying(true);
  }

  void pauseAudio(){
    state.player?.pause();
    setIsPlaying(false);
  }

  void stopAudio(){
    state.player?.stop();
    setIsPlaying(false);
  }

  void seekAudio(Duration position){
    state.player?.seek(position);
  }

  void initializePlayer(){
    final player = AudioPlayer();
    state = state.copyWith(player:player);
  }

  void setAudioSource(AudioSource source) async{
    await state.player?.setAudioSource(source);
  }

  void disposePlayer(){
    state.player?.dispose();
  }
  
  Future<void> loadJson() async {
    // Load JSON string from the file
    final String response = await rootBundle.loadString('assets/bible_summary.json');
    
    // Decode the JSON string into a Dart object (Map or List)
    final data = json.decode(response);
    
    state = state.copyWith(bibleSummary: data);
  }
}