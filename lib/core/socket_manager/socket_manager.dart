// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;
//
// class SocketManager {
//   final cubit = UserInformationCubit.instance;
//
//
//   static final SocketManager _instance = SocketManager._internal();
//   late io.Socket socket;
//
//   factory SocketManager() => _instance;
//
//   SocketManager._internal();
//
//   final audioManager = AudioManager(AssetAudioPlayer());
//
//   void initializeSocket(BuildContext context) {
//
//     final userHiveModel = cubit.state.userHiveModel;
//       socket = io.io(baseUrl, io.OptionBuilder().setTransports(['websocket']).enableAutoConnect().setAuth({"username": userHiveModel.id}).build());
//       socket.onConnect((_) => log('Connected to WebSocket'));
//
//
//       log("initializeSocket $socket");
//       //   socket.on("newOrder", (data) => {
//       //   log('New message: $data'),
//       //  audioManager.play("audio/marimba_app_notice.mp3"),
//       //   context.read<DriverOrdersCubit>().getOrders(),
//       //   log("audio/marimba_app_notice.mp3"),
//       //
//       // // LocalNotificationHandler.showBigTextNotification(title: "You have a new order", body: "", )
//       // });
//       socket.onDisconnect((_) => log('DisConnected WebSocket'));
//   }
//
//   void dispose() {
//       socket.disconnect();
//   }
// }