import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'home.dart';

class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({super.key,required this.items});

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> _selectedItems=[];
  void _itemChange(String itemValue,bool isSelected){
    setState(() {
      if(isSelected){
        _selectedItems.add(itemValue);
      } else{
        _selectedItems.remove(itemValue);
      }
    });
  }
  void _cancel(){
    Navigator.pop(context);
  }
  void _submit(){
    Navigator.pop(context,_selectedItems);
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select Category"),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item)=>CheckboxListTile(
            value: _selectedItems.contains(item),
            title: Text(item),controlAffinity: ListTileControlAffinity.leading,
            onChanged: (isChecked)=>_itemChange(item, isChecked!),)).toList(),
        ),
      ),
      actions: [
        TextButton(onPressed: _cancel, child: Text("Cancel")),
        ElevatedButton(onPressed: _submit, child: Text("Submit")),
      ],
    );
  }
}


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  List<String> _selectedItems=[];
  void _showMultiSelect() async{
   final List<String> items=[
     'Buisness',
     'Entertainment',
     'General',
     'Health',
     'Sports',
   ];
   final List<String>? results=await showDialog(
     context:context,
     builder: (BuildContext context){
       return MultiSelect(items: items);
     },
   );
   if(results!=null){
     setState(() {
       _selectedItems=results;
     });
   }
  }


  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Sign Up",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter UserName", Icons.person_outline,false,_userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email-Id", Icons.person_outline,false,_emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline,true,_passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: _showMultiSelect,
                    child: Text("Select Your Favourite Categories")
                ),
                Divider(
                  height: 30,
                ),
                Wrap(
                  children: _selectedItems.map((e)=>Chip(label:Text(e),)).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context,false,() {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text).then((value) {
                        print("Created New Account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }).onError((error, stackTrace){
                    print("Error ${error.toString()}");
                  });
                })
              ],
            ),
          )
        )
      ),
    );
  }

}
