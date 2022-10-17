// ignore_for_file: prefer_initializing_formals

class CacheSettings {
  Duration duration;
  bool softCache;
  bool sharedPreferences;
  bool enableCaching;

  CacheSettings({
    this.duration = const Duration(days: 1),
    this.softCache = false,
    this.sharedPreferences = true,
    this.enableCaching = false,
  });

}
