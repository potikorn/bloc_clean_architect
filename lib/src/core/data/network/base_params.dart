import 'package:equatable/equatable.dart';

abstract class BaseParams extends Equatable {
  Map<String, String> toMap();
}
