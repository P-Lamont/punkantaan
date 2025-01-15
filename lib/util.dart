import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:punkantaan/home_page.dart';
import 'package:punkantaan/main.dart';

class StanzaColumn extends StatelessWidget {
  const StanzaColumn({
    super.key,
    required this.bodyFontSize,
    required this.listStanza,
  });

  final double bodyFontSize;
  final List<String> listStanza;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: listStanza.map(
        (item) {return LeftAlignText(
          texts: item,
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
    required this.widget,
    required this.songIndex,
    required this.titleFontSize,
    required this.bodyFontSize,
  });

  final MyHomePage widget;
  final int? songIndex;
  final double titleFontSize;
  final double bodyFontSize;

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    return Column( 
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        CenterText(
          texts:"${ref.watch(riverpodProvider).songcontents![songIndex!].title} (${ref.watch(riverpodProvider).songcontents![songIndex!].old})", 
          fontSize: titleFontSize,
          color: Colors.black,
          backgroundColor:(ref.watch(riverpodProvider).highlighted?['type']=='title'&&
            ref.watch(riverpodProvider).highlighted?['index']-1==songIndex)?Colors.yellow:null
        ),
        CenterText(
          texts: 'Tune of:${ref.watch(riverpodProvider).songcontents![songIndex!].tune}', 
          fontSize: bodyFontSize,
          color: Colors.black,
        ),
        Row(
          children: [
            const Spacer(flex: 4,),
            CenterText(
              texts:'Key of ${ref.watch(riverpodProvider).songcontents![songIndex!].key.toUpperCase()}', 
              fontSize: bodyFontSize,
              color: Colors.black,
            ),
            const Spacer(flex: 1,),
            CenterText(
              texts:'Beat: ${ref.watch(riverpodProvider).songcontents![songIndex!].beat}', 
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