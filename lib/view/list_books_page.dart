import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:punkantaan/controller/bible.dart';
class ListBooksPage  extends ConsumerWidget {
  const ListBooksPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final bibleProvider = ref.watch(bibleNotifierProvider);
    final bibleProviderN = ref.watch(bibleNotifierProvider.notifier);
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Books")
      ),
      body:ListView(
        children:bibleProvider.books?.asMap().entries.map((book){
          return ListTile(
            title:Text(book.value),
            onTap: () {
              bibleProviderN.setBookIndex(book.key);
              bibleProviderN.loadAssetsFromFolder(book.value);
              Navigator.pushNamed(context, '/chapter');
            },
          );
        }).toList()??[],
      )
    );
  }
}