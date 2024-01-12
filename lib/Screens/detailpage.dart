import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  String image;
  DetailPage({super.key,required this.image});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      clipBehavior: Clip.antiAlias,
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(

        ),
        child: Image.network("${widget.image}",fit: BoxFit.cover,)));
  }
}
