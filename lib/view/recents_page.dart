import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:punkantaan/main.dart';

class RecentsPage extends ConsumerWidget {
  const RecentsPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final appState = ref.watch(riverpodProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Column(
        children:appState.recent.map((e){
          return ListTile(
            title: Text("$e. ${appState.songcontents![e-1].title}"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: ()async{
              await appState.setSongIndex(e-1);
              if(context.mounted){
                Navigator.pop(context);
              }
            },
          );
        }).toList(),
      ),
    );
  }
}