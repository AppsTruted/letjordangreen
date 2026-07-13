import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final String svgPath;
  final String title;
  final Function function;


  const ListTileWidget({super.key, required this.svgPath,required this.title,required this.function});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        function();
      },
      title: Text(title,style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
      trailing:   Icon( title == "Login" || title == "log Out" ||title== "Orders" ?
      Icons.arrow_forward_ios :Icons.link,size: 18,),
    );
  }
}