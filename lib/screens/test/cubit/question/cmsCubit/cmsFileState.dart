import 'package:flutter/services.dart';
import 'package:test_managment/screens/test/model/questionModel.dart';
import 'package:test_managment/screens/test/testOperation/question/services/cmsServices/wordModel.dart';

abstract class CmsState {}

class CmsInitial extends CmsState {}

class CmsLoading extends CmsState {}

class CMSNoQuestionFound extends CmsState {}

class CMSDeleteSuccess extends CmsState {}

class CMSDeleteError extends CmsState {
  String msg;

  CMSDeleteError({required this.msg});
}

class CmsSuccess extends CmsState {
  WordModel data;

  CmsSuccess({required this.data});
}

class CmsError extends CmsState {
  String msg;

  CmsError({required this.msg});
}
