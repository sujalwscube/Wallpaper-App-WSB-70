import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wsb_70_wallpaperapp/Screens/detailpage.dart';
import '../Models/wallpapermodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController=TextEditingController();
  var mykey="563492ad6f917000010000014276de82636b417392addf236e34b96d";
  late Future<WallpaperModel>wallpaper;
  @override
  void initState() {
    super.initState();
    wallpaper=getWallpaper('lion');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallpaper App"),
        centerTitle: true,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search Wallpapers",
              suffixIcon: IconButton(onPressed: (){
                wallpaper=getWallpaper(searchController.text.toString());
                setState(() {

                });
              }, icon: Icon(Icons.search)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9)
              )
            ),
          ),
        ),
        SizedBox(height: 30),
        FutureBuilder(future: wallpaper, builder: (context,snapshot){
          if(snapshot.hasData){
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: snapshot.data!.photos!.map((photosmodel) =>Padding(
                padding: const EdgeInsets.only(left: 25),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(image: photosmodel.src!.portrait!)));
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.network("${photosmodel.src!.portrait}",fit: BoxFit.cover,),
                  ),
                ),
              ) ).toList()),
            );
          }
          else if(snapshot.hasError){
            return Center(child: Text("${snapshot.hasError.toString()}"),);
          }
          return Center(child: CircularProgressIndicator(),);
        })
      ],),
    );
  }

  Future<WallpaperModel>getWallpaper(String search)async{
    var url="https://api.pexels.com/v1/search?query=$search";
    var response=await http.get(Uri.parse(url),headers: {'Authorization':mykey});
    if(response.statusCode==200){
      var photos=jsonDecode(response.body);
      return WallpaperModel.fromJson(photos);
    }
    else{
      return  WallpaperModel();
    }

  }
}
