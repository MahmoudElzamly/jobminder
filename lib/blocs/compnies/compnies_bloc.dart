
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobminder/blocs/compnies/compnies_events.dart';
import 'package:jobminder/blocs/compnies/compnies_states.dart';
import 'package:jobminder/main.dart';
import 'package:jobminder/utilites/db.dart';


class CompaniesBloc extends Bloc<CompaniesEvent,CompaniesState>{
  CompaniesBloc() : super(const CompaniesInitialState()) {
    on<AddcompanyEvent>(_onAddcompanyEvent,);
  }

  void _onAddcompanyEvent(
    AddcompanyEvent event,
    Emitter<CompaniesState> emitter,
  ) async {
    emitter(const CompaniesInitialState());
    // ignore: unnecessary_null_comparison
    if (event.newComp == null) {
      emitter(const CompaniesErrorAddState(
        errorMessage: "something went very wrong :(",
      ));
    } else {
      event.companies.add(event.newComp);
      locator.get<FirebaseService>().addCompany(event.newComp.name);
      emitter(CompaniesSuccessAddState(event.companies));
    }
  }
  
}