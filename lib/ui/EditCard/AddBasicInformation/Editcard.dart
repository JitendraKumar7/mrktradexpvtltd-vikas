import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mrktradexpvtltd/ui/base/libraryExport.dart';



import 'package:shared_preferences/shared_preferences.dart';






class EditCard extends StatefulWidget{
  final int item;

  const EditCard({Key key, this.item}) : super(key: key);
  @override
  State<StatefulWidget> createState() {

    // TODO: implement createState
    return EditCard1();
  }

}

class EditCard1  extends State<EditCard>{
  Album album =new Album();
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  TextEditingController BsnsOrganization = TextEditingController();
  TextEditingController BsnsDestigation =  TextEditingController();
  TextEditingController Bsnsphn = TextEditingController();
  TextEditingController Bsnsemail =  TextEditingController();
  TextEditingController Bsnsname = TextEditingController();
  TextEditingController Bsnscity =  TextEditingController();
  var  konnectid;

  Future _futurecreatecard;
  Future<Album> createCard(String  Kntid,Natureofbusiness,Catofbusiness,Name ,Organizationname,Phone,Email,Designation,CardType,) async {
    //var jsonResponse = null;

    final http.Response response = await http.post(
      ' https://meo.co.in/meoApiPro/konnectBusiness/index.php/editAbout'
      ,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String  >{
        'id': Kntid,
        'konnect_type':"",
        'name':Name,
        'designation':Designation,
        'email':Email,
        'mobile_number':Phone,
        'company_name':Organizationname,
        'cardType':CardType,
        'referralCode':"",
        'nature_of_business':Natureofbusiness,
        'category_of_business':Catofbusiness,
      }),


    );


    if (response.statusCode == 200 ) {


      var responseJson = json.decode(response.body.toString());
     /* Navigator.push(context, new MaterialPageRoute(
          builder: (context) =>
          new EditCardcreate()));*/

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
  var category=  <String>['Select Category of business', 'Accounting Services', 'Accounting Softwares', ''
      'Acupuncturist','Adult Entertainment','Advertising Srvices','Advertising Specialties'];


  int  _user, _catg;

  var users=<String>['Select nature of  business', 'AGENT', 'EXPORTER', 'IMPORTER','MANUFACTURER',
    'MULTILEVEL MARKETING','ONLINE SELLER','PROFESSIONAL','RETAIL','SERVICE PROVIDER','STUDENT','TRADER','WHOLESALE'];



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text(" Edit your Card ",style: TextStyle(color: Colors.lightBlue),),
          backgroundColor:
          Colors.white,
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
                                Container(alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[400]))
                                  ),
                                  child:
                                  new DropdownButton<String>(
                                    value: _user == null ? null : users[_user],

                                    hint: Text('Select nature of  business'),
                                    items: users.map((String value){  return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                    }).toList(),
                                    onChanged: (value) {

                                      setState(() {
                                        _user = users.indexOf(value);
                                      });
                                    },

                                  ),),
                                SizedBox(height: 10),

                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[400]))
                                  ),
                                  child:
                                  new DropdownButton<String>(
                                    dropdownColor: Colors.amber,
                                    hint: Text('Select Category of business'),

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
                                    controller:Bsnsname,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: " Name of the Person",
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
                                    controller: BsnsOrganization,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Organization Name",
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
                                    controller:BsnsDestigation ,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: " Designation",
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
                                    controller: Bsnsphn,
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

                                    controller:Bsnsemail ,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: " Email Id",
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
                              String knt=konnectid.toString();
                              _futurecreatecard = createCard( Userid,users[_user],category[_catg] ,Bsnsname.text,
                                  BsnsOrganization.text,BsnsDestigation.text,Bsnsphn.text,Bsnsemail.text,CardType);
                              print('aaaaaa${users[_user]}');
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
