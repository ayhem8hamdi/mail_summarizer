// lib/features/home/data/models/adapters/daily_summary_adapter.dart
import 'package:hive/hive.dart';
import 'package:inbox_iq/features/home/data/models/daily_summary_model.dart';
import 'package:inbox_iq/features/home/data/models/email_stats_model.dart';
import 'package:inbox_iq/features/home/data/models/inbox_mood_model.dart';
import 'package:inbox_iq/features/home/data/models/quick_actions_model.dart';
import 'package:inbox_iq/features/home/domain/entities/mood_status_enum.dart';

class DailySummaryAdapter extends TypeAdapter<DailySummaryModel> {
  @override
  final int typeId = 0;

  @override
  DailySummaryModel read(BinaryReader reader) {
    return DailySummaryModel(
      date: reader.readString(),
      totalEmails: reader.readInt(),
      statistics: reader.read() as EmailStatisticsModel,
      mood: reader.read() as InboxMoodModel,
      summary: reader.readString(),
      quickActions: (reader.readList()).cast<QuickActionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, DailySummaryModel obj) {
    writer.writeString(obj.date);
    writer.writeInt(obj.totalEmails);
    writer.write(obj.statistics);
    writer.write(obj.mood);
    writer.writeString(obj.summary);
    writer.writeList(obj.quickActions);
  }
}

class EmailStatisticsAdapter extends TypeAdapter<EmailStatisticsModel> {
  @override
  final int typeId = 1;

  @override
  EmailStatisticsModel read(BinaryReader reader) {
    return EmailStatisticsModel(
      urgent: reader.readInt(),
      actionRequired: reader.readInt(),
      fyi: reader.readInt(),
      read: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, EmailStatisticsModel obj) {
    writer.writeInt(obj.urgent);
    writer.writeInt(obj.actionRequired);
    writer.writeInt(obj.fyi);
    writer.writeInt(obj.read);
  }
}

class InboxMoodAdapter extends TypeAdapter<InboxMoodModel> {
  @override
  final int typeId = 2;

  @override
  InboxMoodModel read(BinaryReader reader) {
    return InboxMoodModel(
      status: MoodStatus.fromString(reader.readString()),
      description: reader.readString(),
      score: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, InboxMoodModel obj) {
    writer.writeString(obj.status.label);
    writer.writeString(obj.description);
    writer.writeDouble(obj.score);
  }
}

class QuickActionAdapter extends TypeAdapter<QuickActionModel> {
  @override
  final int typeId = 3;

  @override
  QuickActionModel read(BinaryReader reader) {
    return QuickActionModel(
      task: reader.readString(),
      completed: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, QuickActionModel obj) {
    writer.writeString(obj.task);
    writer.writeBool(obj.completed);
  }
}
