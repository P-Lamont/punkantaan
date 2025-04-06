import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:punkantaan/model/model_riverpod.dart';

class StanzaColumn extends ConsumerWidget {
  const StanzaColumn({
    super.key,
    required this.bodyFontSize,
    required this.listStanza,
    this.stanza,
    this.highlightedLine,
    this.highlightedStanza,
    this.type,
    this.songIndex,
    this.highlightedIndex
  });

  final double bodyFontSize;
  final List<String> listStanza;
  final int? stanza;
  final int? highlightedLine;
  final int? highlightedStanza;
  final String? type;
  final int? songIndex;
  final int? highlightedIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final appStateN = ref.watch(modelRiverpodProvider.notifier);
    final appState = ref.watch(modelRiverpodProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: listStanza.asMap().entries.map(
        (item) {
          if (item.key+1==highlightedLine && 
          stanza==highlightedStanza && 
          type=='stanza' &&
          songIndex==highlightedIndex){
            return LeftAlignText(
            texts: item.value,
            fontSize:bodyFontSize,
            textcolor:Colors.black,
            backgroundColor: appState.highlightColor,
          );            
          }
          return LeftAlignText(
          texts: item.value,
          fontSize:bodyFontSize,
          textcolor:Colors.black
        );}
      ).toList(),
    );
  }
}

class TitleHeading extends ConsumerWidget {
  const TitleHeading({
    super.key,
    required this.songIndex,
    required this.titleFontSize,
    required this.bodyFontSize,
  });

  final int? songIndex;
  final double titleFontSize;
  final double bodyFontSize;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // final appStateN = ref.watch(modelRiverpodProvider.notifier);
    final appState = ref.watch(modelRiverpodProvider);
    final song = appState.songcontents![songIndex!];
    String oldTitle = song.old!=''?" (${song.old} old)":'';
    return Column( 
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        CenterText(
          texts:"${songIndex!+1}. ${song.title}$oldTitle", 
          fontSize: titleFontSize,
          color: Colors.black,
          backgroundColor:(appState.highlighted?['type']=='title'&&
            appState.highlighted?['index']==songIndex)?appState.highlightColor:null
        ),
        CenterText(
          texts: 'Tune of:${song.tune}', 
          fontSize: bodyFontSize,
          color: Colors.black,
        ),
        Row(
          children: [
            const Spacer(flex: 4,),
            if (song.key.isNotEmpty)CenterText(
              texts:'Key of ${song.key.toUpperCase()}', 
              fontSize: bodyFontSize,
              color: Colors.black,
            ),
            if (song.key.isNotEmpty)const Spacer(flex: 1,),
            CenterText(
              texts:'Beat: ${song.beat}', 
              color: Colors.black,
              fontSize: bodyFontSize,
            ),
            const Spacer(flex: 4,),
          ],
        ),
      ] 
    );
  }
}

class CenterText extends StatelessWidget {
  const CenterText({
    super.key,
    required this.texts,
    required this.fontSize,
    required this.color,
    this.backgroundColor
  });

  final String texts;
  final double fontSize;
  final Color color;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Text(
        texts,
        style: TextStyle(
          fontSize:fontSize, color: color,backgroundColor: backgroundColor
        ),
        overflow: TextOverflow.visible,
        textAlign: TextAlign.center,
    );
  }
}

class LeftAlignText extends StatelessWidget {
  const LeftAlignText({
    super.key,
    required this.texts,
    required this.fontSize,
    required this.textcolor,
    this.backgroundColor
  });

  final String texts;
  final double fontSize;
  final Color textcolor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
          texts,
          style: TextStyle(
            fontSize:fontSize,color: textcolor,backgroundColor: backgroundColor
          ),
          overflow: TextOverflow.visible,
          textAlign: TextAlign.left,
      ),
    );
  }
}