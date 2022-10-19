import 'dart:developer';

import 'package:flutter/services.dart';

import '../communicators/all_communicator.dart';
import '../models/fhir/app_fhir_clases.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'keys_service.dart';

class PractitionerService {
  //Doctores que se encuentran en la app
  final List<AllCommunicator> practitioners = [];

  late AppPractitioner selectedPractitioner;
  bool isLoading = true;
  bool isSaving = false;

  PractitionerService() {
//    this.loadPractitioners();
  }

  Future loadPractitioners() async {
    isLoading = true;

    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'practitioner.json');
    final response = await http.get(url);
    if (json.decode(response.body) != null) {
      final Map<String, dynamic> practitionersMap = json.decode(response.body);
      practitionersMap.forEach((key, value) {
        final tempPracti = AllCommunicator.fromMap(value);
        tempPracti.id = key;
        this.practitioners.add(tempPracti);
      });
      this.isLoading = false;

      return this.practitioners;
    }
    return null;
  }

  Future<Map<String, dynamic>> getPtactitioner(String uId) async {
    isLoading = true;

    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'practitioner/${uId}.json');
    final respuesta = await http.get(url);
    final decodeData = json.decode(respuesta.body);
    if (decodeData == null) {
      return {};
    }
    if (decodeData["active"] != null) {
      return decodeData;
    }
    return {};
  }

  Future<int> obtainCardilogistLenght() async {
    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'cardiologistList/list.json');
    final response = await http.get(url);
    if (json.decode(response.body) != null) {
      List list = json.decode(response.body);
      return list.length;
    }
    return 0;
  }

  Future createPractitioner(AllCommunicator practitioner, String role) async {
    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'practitioner/${practitioner.id}.json');
    final response = await http.put(url, body: practitioner.toJson());
    if (role == "Cardiologo") {
      int nextPosition = await obtainCardilogistLenght();
      final url2 = Uri.https(_baseUrl, 'cardiologistList/list/${nextPosition}.json');
      final url3 = Uri.https(_baseUrl, 'cardiologistList/counter.json');
      final response2 = await http.put(url2, body: json.encode(practitioner.id));
      final response3 = await http.get(url3);
      if (json.decode(response3.body) == null) {
        final url4 = Uri.https(_baseUrl, 'cardiologistList.json');
        await http.patch(url4, body: json.encode({"counter": 0}));
      }
    }
  }

  Future<String> obtainCurrentIndexCardiologist() async {
    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'cardiologistList.json');
    final response = await http.get(url);
    if (json.decode(response.body) != null) {
      Map<String, dynamic> mapValues = json.decode(response.body);
      if (mapValues["counter"] != null) {
        int counter = mapValues["counter"];
        if (mapValues["list"] != null) {
          List listCardio = mapValues["list"];
          if (counter == listCardio.length - 1) {
            counter = 0;

            setCurrentIndexCardiologist(counter);

            return listCardio[counter];
          }
          if (listCardio.length == 1) {
            setCurrentIndexCardiologist(counter);
            return listCardio[counter];
          }
          setCurrentIndexCardiologist(counter + 1);
          return listCardio[counter + 1];
        }
      }
    }
    return "";
  }

  Future<void> setCurrentIndexCardiologist(int newValue) async {
    String _baseUrl = await obtainURL();
    final url = Uri.https(_baseUrl, 'cardiologistList.json');
    final response = await http.patch(url, body: json.encode({"counter": newValue}));
  }
}
