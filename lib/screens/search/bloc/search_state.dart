abstract class SearchState{
}

class InitSearchState extends SearchState{}
class LoadingSearchState extends SearchState{}
class SuccessSearchState extends SearchState{
  final int statusCode;
  final Map<String,dynamic> data;
  SuccessSearchState(this.statusCode, this.data, );
}
class ErrorSearchState extends SearchState{
  final int statusCode;
  final String errorMessage;

  ErrorSearchState(this.statusCode, this.errorMessage);

}