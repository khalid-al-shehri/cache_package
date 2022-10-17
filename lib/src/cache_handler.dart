import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'helpers/network_helper.dart';
import 'helpers/shared_preferences_helper.dart';
import 'models/cache_settings.dart';

class CacheHandler{

  // Cache values depends on dynamic values.
  // For example :-
  // Want to cache response from this API "https://..../api/product/12345"
  /// [cacheKey] : https://..../api/product/12345 (API url)
  Future<Map<String, dynamic>?> cacheAPI({required String apiUrl, CacheSettings? cacheSettings}) async {
    Map<String, dynamic>? value;
    CacheSettings settings = cacheSettings ?? CacheSettings();

    if(settings.enableCaching){
      value = await _checkApiCached(apiUrl);
    }

    value??= await _fetchFromServer(apiUrl);

    if(value != null && !settings.enableCaching){
      // Cache the value
      SharedPreferencesHelper.addStringToSF(keyName: apiUrl, value: json.encode(value));
    }

    return value;
  }

  Future<Map<String, dynamic>?> _checkApiCached(String apiUrl) async {
    bool isValueCached = await SharedPreferencesHelper.check(apiUrl);
    if(isValueCached){
      // get value from cache
      String? cachedValue = await SharedPreferencesHelper.getStringValuesSF(keyName: apiUrl);
      if(cachedValue != null){
        // Debug
        debugPrint("VALUE FROM CACHE");
        return json.decode(cachedValue);
      }
    }
    return null;
  }

  Future<Map<String, dynamic>?> _fetchFromServer(String apiUrl) async {
    debugPrint("TRYING FETCH DATA FROM SERVER");

    Map<String, dynamic>? serverResult;

    serverResult = await NetworkHelper.get(apiUrl);

    debugPrint("Server Result : ${serverResult.toString()}");

    return serverResult;
  }

}