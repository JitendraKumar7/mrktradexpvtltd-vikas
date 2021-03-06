import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mrktradexpvtltd/ui/base/libraryExport.dart';



import 'package:shared_preferences/shared_preferences.dart';






class AddressLocation extends StatefulWidget{
  final int item;

  const AddressLocation({Key key, this.item}) : super(key: key);
  @override
  State<StatefulWidget> createState() {

    // TODO: implement createState
    return AddressLocation1();
  }

}

class AddressLocation1  extends State<AddressLocation>{
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  TextEditingController Address1 = TextEditingController();
  TextEditingController Address2 =  TextEditingController();
  TextEditingController Address3 = TextEditingController();
  TextEditingController Bemail =  TextEditingController();
  TextEditingController Bcontact = TextEditingController();
  TextEditingController Blandn =  TextEditingController();

  var  konnectid;
  Future _futurecreatecard;
  Future<Album> createCard(String  Userid,Catofbusiness,Address1 ,Address2,Address3,Phone,Email,landline,) async {
    //var jsonResponse = null;

    final http.Response response = await http.post(
      ' https://meo.co.in/meoApiPro/konnectBusiness/index.php/addLocation',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String  >{
        'konnect_id': Userid,
        'address_line1':Address1,
        'address_line2':Address2,
        'address_line3':Address3,
        'email':Email,
        'contact_number':Phone,
        'landline':landline,
        'address_type':Catofbusiness,
      }),


    );


    if (response.statusCode == 200 ) {


      var responseJson = json.decode(response.body.toString());
     /* Navigator.push(context, new MaterialPageRoute(
          builder: (context) =>
          new EditCardcreate()));
*/
      Fluttertoast.showToast(
          msg: "data send to sever 111111111111"+response.body,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return  Album.fromJson(json.decode(response.body));

    } else {
      var  jsonResponse = json.decode(response.body);

      throw Exception('Failed to load album');
    }
  }



  var CardType;
  var category=  <String>['Select Address Type', 'Head Office', 'Branch Office',
      'Marketing Office','Regional Office','Home Office','Factory/Workshop','Shop/Showroom','Exhibiton','GoDown'];


  int  _user, _catg;




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text(" Add Address ",style: TextStyle(color: Colors.white),),
          backgroundColor:
          Colors.blue,
          flexibleSpace: Container(
          ),),

        body: SingleChildScrollView(  child:
        Container(
            margin: EdgeInsets.all(24),
            child: Form(
                key: _formKey,
                child:   Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[

                          Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .4),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10)
                                )
                              ]
                          ),
                          child: Column(

                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 20),



                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[400]))
                                  ),
                                  child:
                                  new DropdownButton<String>(
                                    dropdownColor: Colors.amber,
                                    hint: Text('Select Address Type'),

                                    value:  _catg == null ? null : category[_catg],

                                    items:category.map((String value){


                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {

                                      setState(() {
                                        _catg = category.indexOf(value);
                                      });
                                    },

                                  ),),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[400]))
                                  ),
                                  child: TextFormField(
                                    controller:Address1,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Address Line 1",
                                        hintStyle: TextStyle(color: Colors.grey[400])
                                    ),
                                  ),
                                ),
                                Container(

                                  padding: EdgeInsets.all(8.0),

                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[400]))
                                  ),
                                  child: TextFormField(
                                    controller: Address2,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Address Line 2",
                                        hintStyle: TextStyle(color: Colors.grey[400])
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[400]))
                                  ),
                                  child: TextFormField(
                                    controller:Address3 ,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Address Line 3",
                                        hintStyle: TextStyle(color: Colors.grey[400])
                                    ),
                                  ),
                                ),
                                Container(

                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[400]))
                                  ),
                                  child: TextFormField(
                                    controller: Bcontact,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Mobile No",
                                        hintStyle: TextStyle(color: Colors.grey[400])
                                    ),
                                  ),
                                ),
                                Container(

                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[400]))
                                  ),
                                  child: TextFormField(
                                    controller: Bemail,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email Id",
                                        hintStyle: TextStyle(color: Colors.grey[400])
                                    ),
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.all(8.0),

                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[400]))
                                  ),
                                  child: TextFormField(

                                    controller:Blandn ,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Landline No.",
                                        hintStyle: TextStyle(color: Colors.grey[400])
                                    ),
                                  ),
                                ),







                                SizedBox(height: 20),
                                //  _buildPhoneNumber(),
                                //_buildCalories(),
                                SizedBox(height: 20),

                              ])


                      ),
                      SizedBox(height: 30,),
                      Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.lightBlueAccent,

                                    Colors.lightBlue
                                  ]
                              )
                          ),
                          child: InkWell( child:
                          Center(

                            child:
                            Text("Next", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

                          ),
                            onTap: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              var status = prefs.getInt('category');
                              String Userid= status.toString();
                              _futurecreatecard = createCard(konnectid,category[_catg] ,Address1.text,
                                  Address2.text,Address3.text,Bcontact.text,Bemail.text,Blandn.text);

                            },
                          )
                      ),
                      SizedBox(height: 70,),



                    ],
                  ),
                )




            )))
    );
    throw UnimplementedError();
  }
}
