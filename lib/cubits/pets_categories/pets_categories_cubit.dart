import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pets_categories_state.dart';

class PetsCategoriesCubit extends Cubit<PetsCategoriesState> {
  PetsCategoriesCubit() : super(PetsCategoriesInitial());

  static PetsCategoriesCubit get(context) => BlocProvider.of(context);
}
