sealed class Action {
  const Action();
}

/// Text Actions
sealed class TextAction extends Action {
  const TextAction();
}

final class TextSetAction extends TextAction {
  final String text;

  const TextSetAction({
    this.text = 'Default Value',
  });
}

final class TextResetAction extends TextAction {
  const TextResetAction();
}

/// Counter Actions
sealed class CounterAction extends Action {
  const CounterAction();
}

final class CounterIncrementAction extends CounterAction {
  const CounterIncrementAction();
}

@Deprecated('See lessons 2')
final class CounterDecrementAction extends CounterAction {
  const CounterDecrementAction();
}

@Deprecated('See lessons 2')
final class CounterPowerAction extends CounterAction {
  const CounterPowerAction();
}

final class CounterResetAction extends CounterAction {
  const CounterResetAction();
}
