import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox_iq/core/DI/di.dart';
import 'package:inbox_iq/core/utils/app_colors.dart';
import 'package:inbox_iq/features/home/domain/use_cases/get_daily_summary_usecase.dart';
import 'package:inbox_iq/features/home/domain/use_cases/trigger_workflow_usecase.dart';
import 'package:inbox_iq/features/home/presentation/manager/daily_summary_cubit/daily_summary_cubit.dart';
import 'package:inbox_iq/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // ✅ Create Cubit ONLY when HomeView is opened
      create: (context) => DailySummaryCubit(
        getDailySummaryUseCase: sl<GetDailySummaryUseCase>(),
        triggerWorkflowUseCase: sl<TriggerWorkflowUseCase>(),
      )..fetchDailySummary(), // ✅ Auto-fetch on screen open
      child: Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        body: const HomeViewBody(),
      ),
    );
  }
}
