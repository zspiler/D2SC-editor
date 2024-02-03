import 'package:universal_io/io.dart'; // dart:io's Platform does not work in browser for checking OS
import 'package:flutter/services.dart';

const _ctrlKeys = [LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.controlRight];
const _metaKeys = [LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.meta];

class KeyboardShortcutManager {
  static final _scrollKeys = Platform.operatingSystem == 'macos' ? _metaKeys : _ctrlKeys;
  static final _deleteKeys = [LogicalKeyboardKey.delete, LogicalKeyboardKey.backspace];
  static final _deselectKeys = [LogicalKeyboardKey.escape];
  static final _cancelDrawingKeys = [LogicalKeyboardKey.escape];

  static bool isMetaPressed(RawKeyboard rawKeyboard) {
    return _metaKeys.any((key) => RawKeyboard.instance.keysPressed.contains(key));
  }

  static bool isCtrlPressed(RawKeyboard rawKeyboard) {
    return _ctrlKeys.any((key) => RawKeyboard.instance.keysPressed.contains(key));
  }

  static bool isScrollKeyPresseed(RawKeyboard rawKeyboard) {
    return _scrollKeys.any((key) => RawKeyboard.instance.keysPressed.contains(key));
  }

  static bool isDeleteKeyPressed(RawKeyboard rawKeyboard) {
    return _deleteKeys.any((key) => RawKeyboard.instance.keysPressed.contains(key));
  }

  static bool isDeselectKeyPressed(RawKeyboard rawKeyboard) {
    return _deselectKeys.any((key) => RawKeyboard.instance.keysPressed.contains(key));
  }

  static bool isCancelDrawingKeyPressed(RawKeyboard rawKeyboard) {
    return _cancelDrawingKeys.any((key) => RawKeyboard.instance.keysPressed.contains(key));
  }
}