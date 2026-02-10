import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:punkantaan/model/model_riverpod.dart';

class RecentsPage extends ConsumerStatefulWidget {
  const RecentsPage({super.key});

  @override
  ConsumerState<RecentsPage> createState() => _RecentsPageState();
}

class _RecentsPageState extends ConsumerState<RecentsPage> {
  final ScrollController _scrollRec = ScrollController(
    keepScrollOffset: false
  );
  @override
  void dispose(){
    _scrollRec.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final appStateN = ref.watch(modelRiverpodProvider.notifier);
    final appState = ref.watch(modelRiverpodProvider);
    // final scroll = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recents'),
      ),
      body: Scrollbar(
        controller: _scrollRec,
        thickness: 15.0,
        child: ListView(
          children:appState.recent.map((e){
            return ListTile(
              title: Text("$e. ${appState.songcontents![e-1].title}"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: ()async{
                await appStateN.setSongIndex(e-1);
                if(context.mounted){
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}