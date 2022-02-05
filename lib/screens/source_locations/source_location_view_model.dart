import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projects/models/source_entity.dart';
import 'package:projects/utilts/helper_functions.dart';
import 'package:projects/viewModels/base_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SourceLocationsViewModel extends BaseViewModel {
  QuerySnapshot<Map<String, dynamic>>? _locationsRef;
  TextEditingController? controller;
  List<SourceEntity> locations = [];
  RefreshController? refreshController ;
  int page = 0;
  DocumentSnapshot? _lastDoc;
  FirebaseFirestore? _db;

  SourceLocationsViewModel() {
    controller = TextEditingController();
    _db = FirebaseFirestore.instance;
    refreshController = RefreshController(initialRefresh: false);
  }

  searchOnLocations() async {
    try {
      if (controller!.text.trim().isEmpty) {
        HelperFunctions.toast(text: "You must type something first..");
      }
      _locationsRef = await _db!
          .collection('Source')
          .orderBy("name")
          .where("name", isGreaterThanOrEqualTo: controller!.text.trim())
          .where("name", isLessThan: controller!.text.trim() + "z")
          .limit(10)
          .get();
      _addToLocationList();
    } catch (e) {
      print(e);
    }
  }

  loadMoreResults() async {
    try {
      _locationsRef = await _db!
          .collection('Source')
          .orderBy("name")
          .where("name", isGreaterThanOrEqualTo: controller!.text.trim())
          .where("name", isLessThan: controller!.text.trim() + "z")
          .startAfterDocument(_lastDoc!)
          .limit(10)
          .get();
      _addToLocationList();
    } catch (e) {
      print(e);
    }
  }

  _addToLocationList() {
    if (_locationsRef!.docs.isNotEmpty) {
      List<SourceEntity> _locations = _locationsRef!.docs
          .map<SourceEntity>((item) => SourceEntity().fromJson(item.data()))
          .toList();
      if(_lastDoc != null){
        locations.addAll(_locations);
      }else{
        locations = _locations;
      }
      _lastDoc = _locationsRef!.docs.last;
      notifyListeners();
    }
  }

  checkValue(String value) {
    locations = [];
    _lastDoc = null;
    notifyListeners();
  }

  void onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 400));
    // if failed,use refreshFailed()
    _lastDoc = null;
    searchOnLocations();
    refreshController!.refreshCompleted();
  }

  void onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 400));
    loadMoreResults();
    refreshController!.loadComplete();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    refreshController!.dispose();
    controller!.dispose();
  }
}
