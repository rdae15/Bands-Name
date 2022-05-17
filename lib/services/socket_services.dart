// ignore_for_file: constant_identifier_names, avoid_print, unused_field, library_prefixes
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;



enum SeverStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {
  late IO.Socket _socket;
  SeverStatus _severStatus = SeverStatus.Connecting;

  SeverStatus get serverStatus => _severStatus;
  IO.Socket get socket => _socket;

  SocketService(){
    _initConfig();
  }

  void _initConfig(){
  _socket = IO.io('http://10.0.2.2:3000', {
    'transports': ['websocket'],
    'autoConnect': true,
  });
  _socket.on('connect',(_) {
    _severStatus = SeverStatus.Online;
    notifyListeners();
  });
  _socket.on('disconnect',(_){
     _severStatus = SeverStatus.Offline;
    notifyListeners();
  });
  }

}