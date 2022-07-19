import 'package:flutter/services.dart';

FilteringTextInputFormatter filterOnlyChars =
    FilteringTextInputFormatter.allow(RegExp(r'[A-Z]'));
