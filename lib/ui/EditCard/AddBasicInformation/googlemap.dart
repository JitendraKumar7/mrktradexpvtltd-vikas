import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mrktradexpvtltd/ui/EditCard/AddBasicInformation/Address%20location.dart';





class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 15),

        ),

      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:AppBar(
        title:const  Text(  " Access Location "??"", textAlign: TextAlign.start,style:TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontFamily: "Product Sans" ),),),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _initialcameraposition),

        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,


      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, new MaterialPageRoute(
              builder: (context) =>
              new AddressLocation()));
         // _settingModalBottomSheet(context);
          // Add your onPressed code here!
        },
        child: Text("Next", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.lightBlue,
      ),




    );
  }


}