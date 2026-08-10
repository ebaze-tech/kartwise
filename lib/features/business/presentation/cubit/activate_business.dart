import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveBusinessCubit extends Cubit<String?> {
  ActiveBusinessCubit() : super(null);

  void setActiveBusiness(String businessId) => emit(businessId);

  void clearActiveBusiness() => emit(null);
}
