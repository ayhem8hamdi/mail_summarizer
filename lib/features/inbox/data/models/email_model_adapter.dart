import 'package:hive/hive.dart';
import 'package:inbox_iq/features/inbox/data/models/email_model.dart';
import 'package:inbox_iq/features/inbox/domain/entities/email_entity.dart';

class EmailModelAdapter extends TypeAdapter<EmailModel> {
  @override
  final int typeId = 4; // Unique ID for this adapter

  @override
  EmailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return EmailModel(
      id: fields[0] as String,
      senderName: fields[1] as String,
      senderEmail: fields[2] as String,
      subject: fields[3] as String,
      snippet: fields[4] as String,
      classification: fields[5] as String,
      priority: EmailPriority.values[fields[6] as int],
      keyDetails: fields[7] as String,
      deadline: fields[8] as String,
      requiresAction: fields[9] as bool,
      reason: fields[10] as String,
      timestamp: DateTime.parse(fields[11] as String),
      hasAttachment: fields[12] as bool,
      isRead: fields[13] as bool,
      isStarred: fields[14] as bool,
      isArchived: fields[15] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, EmailModel obj) {
    writer
      ..writeByte(16) // Number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.senderName)
      ..writeByte(2)
      ..write(obj.senderEmail)
      ..writeByte(3)
      ..write(obj.subject)
      ..writeByte(4)
      ..write(obj.snippet)
      ..writeByte(5)
      ..write(obj.classification)
      ..writeByte(6)
      ..write(obj.priority.index)
      ..writeByte(7)
      ..write(obj.keyDetails)
      ..writeByte(8)
      ..write(obj.deadline)
      ..writeByte(9)
      ..write(obj.requiresAction)
      ..writeByte(10)
      ..write(obj.reason)
      ..writeByte(11)
      ..write(obj.timestamp.toIso8601String())
      ..writeByte(12)
      ..write(obj.hasAttachment)
      ..writeByte(13)
      ..write(obj.isRead)
      ..writeByte(14)
      ..write(obj.isStarred)
      ..writeByte(15)
      ..write(obj.isArchived);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
