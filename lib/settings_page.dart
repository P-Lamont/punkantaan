import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:punkantaan/main.dart';
import 'package:punkantaan/licenses_page.dart';
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final appState = ref.watch(riverpodProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Title Font Size'),
            Slider(
              value: appState.titleFontSize,
              onChanged: appState.setTitleSize,
              max: 30,
              min: 16,
            ),
            const Text('Body Font Size'),
            Slider(
              value: appState.bodyFontSize,
              onChanged: appState.setBodySize,
              max: 30,
              min: 16,
            ),
            const Text('Highlight color'),
            const HighlightColorPicker(),
            ElevatedButton(
              onPressed: appState.setDefaultSettings, 
              child: const Text('Set Default')
            ),
            ElevatedButton(
              onPressed:()async{
                Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => const AppLicensePage()),
                  );
              },  
              child: Text('Licenses'))
            // TextButton(onPressed: ()async{
            // }
            // , child: child)
            // ColorPicker(
            //   pickerColor: Colors.red,
            //   onColorChanged: appState.changeColorHighlight,
            // )               
          ],
        ),
      ),
    );
  }

}
class HighlightColorPicker extends ConsumerStatefulWidget {
  const HighlightColorPicker({super.key});
  @override
  ConsumerState  createState() => _HighlightColorPickerState();
}
class _HighlightColorPickerState extends ConsumerState<HighlightColorPicker> {
  Color? pickerColor;
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }
  void _showAlertDialog(BuildContext context,WidgetRef ref){

    final appState = ref.watch(riverpodProvider);
    pickerColor =appState.highlightColor;
    showDialog(
      context: context,
      builder: (BuildContext context){
        return  AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor!,
              onColorChanged:changeColor,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: ()async{
                // print('${pickerColor.red},${pickerColor.green},${pickerColor.blue},${pickerColor.alpha}');
                await appState.changeColorHighlight(pickerColor!);
                if(context.mounted){
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
  @override 
  Widget build(BuildContext context) { 
    return ElevatedButton( 
      onPressed: () => _showAlertDialog(context,ref), 
      child: const Text('Color Picker'), 
    ); 
  }
}