// theme.dart
import 'package:flutter/material.dart';

abstract class AppTheme {
  Color get backgroundColor;
  Color get appBarColor;
  Color get appBarTitleTextStyle;
  Color get backArrowColor;
  Color get themeIconColor;
  Color get flashingCircleBrightColor;
  Color get flashingCircleDarkColor;
  Color get textFieldBackgroundColor;
  Color get sendButtonColor;
  Color get outgoingChatBubbleColor;
  Color get inComingChatBubbleColor;
  Color get inComingChatBubbleTextColor;
  Color get messageTimeTextColor;
  Color get messageTimeIconColor;
  Color get chatHeaderColor;
  Color get replyMessageColor;
  Color get replyDialogColor;
  Color get replyTitleColor;
  Color get closeIconColor;
  Color get cameraIconColor;
  Color get galleryIconColor;
  Color get recordIconColor;
  Color get waveColor;
  Color get waveformBackgroundColor;
  Color get replyMicIconColor;
  Color get reactionPopupColor;
  Color get repliedMessageColor;
  Color get verticalBarColor;
  Color get replyPopupColor;
  Color get replyPopupButtonColor;
  Color get replyPopupTopBorderColor;
  Color get messageReactionBackGroundColor;
  Color get shareIconBackgroundColor;
  Color get shareIconColor;
  Color get linkPreviewOutgoingChatColor;
  Color get linkPreviewIncomingChatColor;
  TextStyle get outgoingChatLinkBodyStyle;
  TextStyle get outgoingChatLinkTitleStyle;
  TextStyle get incomingChatLinkBodyStyle;
  TextStyle get incomingChatLinkTitleStyle;
}

class LightTheme extends AppTheme {
  @override
  Color get backgroundColor => Colors.white;

  @override
  Color get appBarColor => Colors.pinkAccent;

  @override
  Color get appBarTitleTextStyle => Colors.white;

  @override
  Color get backArrowColor => Colors.white;

  @override
  Color get themeIconColor => Colors.black;
  
  @override
  Color get flashingCircleBrightColor => Colors.green;

  @override
  Color get flashingCircleDarkColor => Colors.red;

  @override
  Color get textFieldBackgroundColor => Colors.grey.shade200;

  @override
  Color get sendButtonColor => Colors.pinkAccent;

  @override
  Color get outgoingChatBubbleColor => Colors.blue.shade100;

  @override
  Color get inComingChatBubbleColor => Colors.grey.shade300;

  @override
  Color get inComingChatBubbleTextColor => Colors.black;
  
  @override
  Color get messageTimeTextColor => Colors.grey;
  
  @override
  Color get messageTimeIconColor => Colors.grey;

  @override
  Color get chatHeaderColor => Colors.black;

  @override
  Color get replyMessageColor => Colors.lightBlue;

  @override
  Color get replyDialogColor => Colors.grey.shade400;

  @override
  Color get replyTitleColor => Colors.black;

  @override
  Color get closeIconColor => Colors.red;

  @override
  Color get cameraIconColor => Colors.blue;

  @override
  Color get galleryIconColor => Colors.purple;

  @override
  Color get recordIconColor => Colors.red;

  @override
  Color get waveColor => Colors.blue;

  @override
  Color get waveformBackgroundColor => Colors.grey.shade200;

  @override
  Color get replyMicIconColor => Colors.blueAccent;

  @override
  Color get reactionPopupColor => Colors.white;

  @override
  Color get repliedMessageColor => Colors.grey.shade400;

  @override
  Color get verticalBarColor => Colors.blue;

  @override
  Color get replyPopupColor => Colors.grey.shade300;

  @override
  Color get replyPopupButtonColor => Colors.black;

  @override
  Color get replyPopupTopBorderColor => Colors.grey.shade500;

  @override
  Color get messageReactionBackGroundColor => Colors.grey.shade400;

  @override
  Color get shareIconBackgroundColor => Colors.blueAccent;

  @override
  Color get shareIconColor => Colors.white;

  @override
  Color get linkPreviewOutgoingChatColor => Colors.blue.shade50;

  @override
  Color get linkPreviewIncomingChatColor => Colors.grey.shade200;

  @override
  TextStyle get outgoingChatLinkBodyStyle => TextStyle(color: Colors.blue);

  @override
  TextStyle get outgoingChatLinkTitleStyle => TextStyle(color: Colors.black);

  @override
  TextStyle get incomingChatLinkBodyStyle => TextStyle(color: Colors.black);

  @override
  TextStyle get incomingChatLinkTitleStyle => TextStyle(color: Colors.black);
}
