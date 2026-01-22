enum EmailPriority { urgent, action, fyi, normal }

class EmailEntity {
  final String id;
  final String sender;
  final String subject;
  final String preview;
  final String time;
  final bool isRead;
  final EmailPriority priority;
  final bool hasAttachment;

  const EmailEntity({
    required this.id,
    required this.sender,
    required this.subject,
    required this.preview,
    required this.time,
    this.isRead = false,
    this.priority = EmailPriority.normal,
    this.hasAttachment = false,
  });
}

// Mock data
final List<EmailEntity> mockEmails = [
  const EmailEntity(
    id: '1',
    sender: 'Sarah Johnson',
    subject: 'Project Deadline Extension Request',
    preview:
        'Hi there, I wanted to discuss the possibility of extending our project deadline by a few days due to some...',
    time: '9:30 AM',
    isRead: false,
    priority: EmailPriority.urgent,
    hasAttachment: false,
  ),
  const EmailEntity(
    id: '2',
    sender: 'Marketing Team',
    subject: 'Q1 Campaign Performance Report',
    preview:
        'Please find attached the comprehensive report on our Q1 marketing campaigns. The results exceeded expectations...',
    time: '8:45 AM',
    isRead: false,
    priority: EmailPriority.normal,
    hasAttachment: true,
  ),
  const EmailEntity(
    id: '3',
    sender: 'David Chen',
    subject: 'Meeting Invitation: Design Review',
    preview:
        'I would like to schedule a design review meeting for next week. Please let me know your availability for Tuesday or...',
    time: '7:20 AM',
    isRead: false,
    priority: EmailPriority.action,
    hasAttachment: false,
  ),
  const EmailEntity(
    id: '4',
    sender: 'Jessica Williams',
    subject: 'Budget Approval Needed',
    preview:
        'The proposed budget for the new initiative requires approval. I have attached the detailed breakdown and...',
    time: 'Yesterday',
    isRead: false,
    priority: EmailPriority.urgent,
    hasAttachment: true,
  ),
  const EmailEntity(
    id: '5',
    sender: 'Tech Support',
    subject: 'System Maintenance Notification',
    preview:
        'Our systems will undergo scheduled maintenance this weekend. Please save your work and log out by Friday...',
    time: 'Yesterday',
    isRead: true,
    priority: EmailPriority.fyi,
    hasAttachment: false,
  ),
  const EmailEntity(
    id: '6',
    sender: 'HR Department',
    subject: 'Employee Benefits Update',
    preview:
        'We are excited to announce new additions to our employee benefits package starting next quarter...',
    time: '2 days ago',
    isRead: true,
    priority: EmailPriority.normal,
    hasAttachment: true,
  ),
];
