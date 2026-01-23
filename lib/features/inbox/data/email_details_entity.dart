import 'package:inbox_iq/features/inbox/data/email_entity.dart';

class EmailDetailEntity {
  final String id;
  final String sender;
  final String senderEmail;
  final String subject;
  final String body;
  final String time;
  final EmailPriority priority;
  final bool hasAttachment;
  final String? senderInitial;

  const EmailDetailEntity({
    required this.id,
    required this.sender,
    required this.senderEmail,
    required this.subject,
    required this.body,
    required this.time,
    required this.priority,
    this.hasAttachment = false,
    this.senderInitial,
  });
}

// Mock data
final EmailDetailEntity mockEmailDetail = EmailDetailEntity(
  id: '1',
  sender: 'Sarah Johnson',
  senderEmail: 'sarah.johnson@techcorp.com',
  subject: 'Project Deadline Extension Request',
  body: '''Hi there,

I wanted to discuss the possibility of extending our project deadline by a few days due to some unexpected technical challenges we've encountered.

I understand this may require some adjustments to our timeline, but I believe the additional time will ensure we deliver a higher quality result. The technical challenges we've encountered are being addressed, but they need proper attention to avoid future issues.

Could we schedule a brief call to discuss this in more detail? I'm available tomorrow afternoon or Thursday morning.

Best regards,
Sarah Johnson''',
  time: '9:30 AM',
  priority: EmailPriority.urgent,
  hasAttachment: false,
  senderInitial: 'S',
);
