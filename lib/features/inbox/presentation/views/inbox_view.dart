import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox_iq/core/DI/di.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/features/inbox/domain/usecases/filtered_emails_usecase.dart';
import 'package:inbox_iq/features/inbox/domain/usecases/get_emails_use_case.dart';
import 'package:inbox_iq/features/inbox/presentation/manager/inbox_cubit/inbox_cubit.dart';
import 'package:inbox_iq/features/inbox/presentation/views/widgets/inbox_view_body.dart';

class InboxView extends StatelessWidget {
  const InboxView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InboxCubit(
        getEmailsUseCase: sl<GetEmailsUseCase>(),
        getFilteredEmailsUseCase: sl<GetFilteredEmailsUseCase>(),
      )..fetchEmails(), // Auto-fetch on screen open
      child: const Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        body: InboxViewBody(),
      ),
    );
  }
}
