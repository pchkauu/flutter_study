// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppState {
  final int count;
  final String text;

  const AppState({
    this.count = 0,
    this.text = 'Empty',
  });

  AppState copyWith({
    int? count,
    String? text,
  }) {
    return AppState(
      count: count ?? this.count,
      text: text ?? this.text,
    );
  }
}
