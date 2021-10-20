import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    
  ));
}

class KayitEkrani extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<KayitEkrani> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var snackBar1 = SnackBar(content: Text("Kayıt eklendi."), backgroundColor: Colors.green,);
  var snackBar2 = SnackBar(content: Text("Şifre en az 8 karakter olmalıdır."), backgroundColor: Colors.red,);
  String dropdownValue = 'İşletme Sahibi';

  //ADD RECORD TO FIREBASE
  kaydol()
  {
    if(passwordController.text.length<8)
    {
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
    }
    else
    {
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).whenComplete(() => print('kayıt eklendi'));
      FirebaseFirestore.instance
          .collection("Users")
          .doc(emailController.text)
          .set({'email': emailController.text, 'name': nameController.text, 'password': passwordController.text, 'surname': surnameController.text, 'tel': telController.text, 'tip': dropdownValue}).whenComplete(() => print('Kayıt ekleme başarılı...'));
      
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(
                      'assets/images/Background3.png'),
                  fit: BoxFit.cover,
                )),
            padding: EdgeInsets.all(10),
            child: ListView(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              children: <Widget>[
                Container(
                  child: IconButton(
                    onPressed: giriseDon,
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Kayıt',
                      style: TextStyle(
                          color: Color.fromRGBO(141, 110, 99, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,),
                      ),
                      labelText: 'Ad',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: surnameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,),
                      ),
                      labelText: 'Soyad',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: telController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,),
                      ),
                      labelText: 'Telefon',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,),
                      ),
                      labelText: 'Şifre',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 22,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['İşletme Sahibi', 'Katılımcı', 'Etkinlik Sahibi']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Color.fromRGBO(141, 110, 99, 1),
                      child: Text('Kaydol'),
                      onPressed: kaydol,
                    )),
              ],
            )));
  }
}
