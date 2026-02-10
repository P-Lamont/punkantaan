import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:punkantaan/controller/bible.dart';

class ChaptersPage extends ConsumerWidget {
  const ChaptersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bibleProvider = ref.watch(bibleNotifierProvider);
    final bibleProviderN = ref.watch(bibleNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapters'),
      ),
      body: ListView(
        children: bibleProvider.chapters?.asMap().entries.map((chapter) {
          final chapterSplit = chapter.value.split('-')[1].split('.')[0];
          return ListTile(
            title: Text(chapterSplit),
            onTap: (){
              bibleProviderN.setChapterIndex(chapter.key);
              Navigator.pushNamed(context,'/reading');
            },
          );
        }).toList() ?? [],
      )
    );
  }
}
