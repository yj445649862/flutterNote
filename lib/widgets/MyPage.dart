import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_note/models/i_m_message.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSDKListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSimpleMsgListener.dart';
import 'package:tencent_im_sdk_plugin/enum/log_level.dart';
import 'package:tencent_im_sdk_plugin/manager/v2_tim_manager.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  // initLisener(data){
  //   String type = data.type;
  //   switch(type){
  //     case: 'onConnecting':
  //   case: 'onConnectSuccess':
  //   case: 'onConnectFailed':
  //   case: 'onKickedOffline':
  //   case: 'onUserSigExpired':
  //   case: 'onSelfInfoUpdated':
  //   }
  // }
  //
  //  //获取腾讯即时通信IM manager;
  V2TIMManager timManager = TencentImSDKPlugin.v2TIMManager;
  late V2TimValueCallback<bool> initRes;
  //
  //

  @override
  void initState() {
    initListener();
    super.initState();
  }

  initLisener(data) {
    String type = data.type;
    print('---$type----');
  }

  initListener() async {
    initRes = await timManager.initSDK(
      sdkAppID: 1400515331, //填入在控制台上申请的sdkappid
      loglevel: LogLevel.V2TIM_LOG_DEBUG,
      listener: V2TimSDKListener(
          onConnecting: () => print('链接中'),
          onConnectFailed: (a, b) => print('链接失败'),
          onConnectSuccess: () {
            timManager.login(
              userID: "im_doc_18701416523",
              userSig:
                  "eJw1jtEKgjAYRt9l1yH7nZtL6FIq2kVoRHUj0qb*2sxURIjePdG6-M7hwPcmJxU7ZmywNSQQ1JOUrmY2mJYExHUoWXanq7RpUJMAPEo5cMZgMahN3WOGc4A20c97AtKn4IHgLvv3mE86DPPHcL51r4wdol2p1BjbKKp8jbosLqyrt22xv6bqWMvNL*zRTtdAMJBcuGvx*QJmPDTZ",
            );
          },
          onKickedOffline: () => print('被踢掉'),
          onUserSigExpired: () => print('签名过期'),
          onSelfInfoUpdated: (info) => print('个人信息更新,$info')),
    );
    timManager.addSimpleMsgListener(listener: V2TimSimpleMsgListener(
      onRecvC2CTextMessage: (message, userInfo, extra) {
        print('$message, ${userInfo.nickName}, $extra');
      },
    ));
    int code = initRes.code;
    bool? data = initRes.data;
    print('$code,$data');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('index$index'),
              );
            },
            itemCount: 12,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                V2TimValueCallback<V2TimMessage> data =
                    await timManager.sendC2CTextMessage(
                        text: jsonEncode(IMMessage(
                            typeTemplate: '1', ext: Ext(message: '12312'))),
                        userID: 'im_user_143_188');
                // print(data.data!.userID!.toString());
              },
              child: Text('发送'),
            ),
          ],
        )
      ],
    );
  }
}
