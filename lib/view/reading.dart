import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:punkantaan/controller/bible.dart';

class ReadingPage extends ConsumerStatefulWidget{
  const ReadingPage({super.key});

  @override
  ConsumerState<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends ConsumerState<ReadingPage> {
  @override
  void dispose(){
    final bibleProviderN =ref.watch(bibleNotifierProvider.notifier);
    bibleProviderN.disposePlayer();
    super.dispose();
  }
  Widget build(BuildContext context){
    final bibleProvider =ref.watch(bibleNotifierProvider);
    final bibleProviderN =ref.watch(bibleNotifierProvider.notifier);
    // final currentBook = bibleProvider.books?[bibleProvider.currentBookIndex!];
    final currentChapter = bibleProvider.chapters?[bibleProvider.currentChapterIndex!];
    AudioSource source = AudioSource.asset('$currentChapter');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading'),
      ),
      body: Container(
        child: Column(
          children: [
            StreamBuilder<Duration>(
              stream: bibleProvider.player?.positionStream, 
              builder: bibleProvider.player?.positionStream!=null?(context,snapshot){
                final duration = snapshot.data ?? Duration.zero;
                return Slider(
                  value:duration.inSeconds.toDouble()??0,
                  max:bibleProvider.player?.duration?.inSeconds.toDouble()??0,
                  onChanged: (value) => {
                    bibleProviderN.seekAudio(Duration(seconds:value.toInt()))
                  },
                );
              }:(context,snapshot){
                return const Slider(
                  value: 0,
                  max: 0,
                  onChanged: null,
                );
              }
            ),
            Row(
              children: [
                IconButton(
                  onPressed: ()async{
                  bibleProviderN.prevAudio();
            
                  // await player.setAudioSource(source);
            
                  bibleProviderN.playAudio();         
                  }, 
                  icon:const Icon(Icons.skip_previous)
                ),
                IconButton(
                  onPressed: null, 
                  icon:const Icon(Icons.fast_rewind)
                ),
                IconButton(
                  onPressed: ()async{
                  // AudioSource source = AudioSource.asset(chapter);
                  if (bibleProvider.isPlaying==false){
                    // bibleProviderN.setIsPlaying(true);
                    // await player.setAudioSource(source);
                    bibleProvider.player?.setAudioSource(source);
                    bibleProviderN.playAudio();
                    // await player.play(); 
                  }else{
                    // bibleProvider.player?.setAudioSource(source);
                    bibleProviderN.pauseAudio(); 
                  }
                   
                  }, 
                  icon:Icon(bibleProvider.isPlaying==false?Icons.play_arrow:Icons.pause)
                ),
                IconButton(
                  onPressed: null, 
                  icon:const Icon(Icons.fast_forward)
                ),
                IconButton(
                  onPressed: ()async{
                  bibleProviderN.nextAudio();
                  // AudioSource source R= AudioSource.asset(chapter);
                  bibleProvider.player?.setAudioSource(source);
            
                  bibleProviderN.playAudio();         
                  }, 
                  icon:const Icon(Icons.skip_next)
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}