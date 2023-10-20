import 'dart:convert';

import 'package:newsapp/models/news/show_category.dart';

import '../models/news/slider_model.dart';
import 'package:http/http.dart' as http;

class ShowCategoryNews{
  List<ShowCategoryModel> categories=[];


  Future<void> getCategoriesNews(String category)async{
    String url="https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=37996ba8b5a140699d6ace871222b594";
    var response= await http.get(Uri.parse(url));
    var jsonData=jsonDecode(response.body);
    if(jsonData['status']=='ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element['description']!=null){
          ShowCategoryModel categorymodel=ShowCategoryModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          categories.add(categorymodel);
        }
      });
    }

  }
}