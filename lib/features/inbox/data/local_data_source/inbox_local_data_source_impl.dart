import 'package:hive/hive.dart';
import 'package:inbox_iq/core/failure/exceptions.dart';
import 'package:inbox_iq/features/inbox/data/local_data_source/inbox_local_data_source.dart';
import 'package:inbox_iq/features/inbox/data/models/email_model.dart';

class InboxLocalDataSourceImpl implements InboxLocalDataSource {
  static const String _emailsBoxName = 'emails_box';
  static const String _emailsKey = 'cached_emails';
  static const String _timestampKey = 'cache_timestamp';

  // Cache validity duration (e.g., 30 minutes)
  static const Duration _cacheValidity = Duration(minutes: 30);

  Box<dynamic>? _box;

  Future<Box<dynamic>> _getBox() async {
    try {
      if (_box != null && _box!.isOpen) {
        return _box!;
      }
      _box = await Hive.openBox(_emailsBoxName);
      return _box!;
    } catch (e) {
      print('❌ Error opening Hive box: $e');
      rethrow;
    }
  }

  @override
  Future<List<EmailModel>> getCachedEmails() async {
    try {
      final box = await _getBox();
      final cached = box.get(_emailsKey);

      print('📦 Getting cached emails...');
      print('📦 Cached data type: ${cached.runtimeType}');
      print('📦 Cached data is null: ${cached == null}');

      if (cached == null) {
        print('📦 No cached emails found');
        return [];
      }

      if (cached is List) {
        print('📦 Found ${cached.length} cached emails');
        return cached.cast<EmailModel>().toList();
      }

      print('⚠️ Cached data is not a List');
      return [];
    } catch (e) {
      print('❌ Error getting cached emails: $e');
      throw CacheException(
        message: 'Failed to retrieve cached emails',
        details: e.toString(),
      );
    }
  }

  @override
  Future<void> cacheEmails(List<EmailModel> emails) async {
    try {
      print('💾 Caching ${emails.length} emails...');
      final box = await _getBox();
      await box.put(_emailsKey, emails);
      await box.put(_timestampKey, DateTime.now().toIso8601String());
      print('✅ Successfully cached ${emails.length} emails');
    } catch (e) {
      print('❌ Error caching emails: $e');
      throw CacheException(
        message: 'Failed to cache emails',
        details: e.toString(),
      );
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final box = await _getBox();
      await box.delete(_emailsKey);
      await box.delete(_timestampKey);
      print('🗑️ Cache cleared successfully');
    } catch (e) {
      print('❌ Error clearing cache: $e');
      throw CacheException(
        message: 'Failed to clear cache',
        details: e.toString(),
      );
    }
  }

  @override
  Future<EmailModel?> getCachedEmailById(String emailId) async {
    try {
      final emails = await getCachedEmails();
      try {
        return emails.firstWhere((email) => email.id == emailId);
      } catch (e) {
        print('⚠️ Email with id $emailId not found in cache');
        return null;
      }
    } catch (e) {
      print('❌ Error getting cached email by id: $e');
      return null;
    }
  }

  @override
  Future<bool> hasCachedData() async {
    try {
      final box = await _getBox();
      final cached = box.get(_emailsKey);
      final timestampStr = box.get(_timestampKey);

      print('🔍 Checking for cached data...');
      print('🔍 Has cached emails: ${cached != null}');
      print('🔍 Has timestamp: ${timestampStr != null}');

      if (cached == null || timestampStr == null) {
        print('🔍 No valid cached data');
        return false;
      }

      // Check if cache is still valid
      final timestamp = DateTime.parse(timestampStr as String);
      final now = DateTime.now();
      final difference = now.difference(timestamp);

      final isValid =
          difference < _cacheValidity && (cached as List).isNotEmpty;
      print('🔍 Cache age: ${difference.inMinutes} minutes');
      print('🔍 Cache is valid: $isValid');

      return isValid;
    } catch (e) {
      print('❌ Error checking cached data: $e');
      return false;
    }
  }

  /// Get cache age in minutes
  Future<int?> getCacheAgeInMinutes() async {
    try {
      final box = await _getBox();
      final timestampStr = box.get(_timestampKey);

      if (timestampStr == null) return null;

      final timestamp = DateTime.parse(timestampStr as String);
      final now = DateTime.now();
      return now.difference(timestamp).inMinutes;
    } catch (e) {
      return null;
    }
  }
}
