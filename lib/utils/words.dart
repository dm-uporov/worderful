import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:words_remember/model/Word.dart';

const int int64MaxValue = 9223372036854775807;

typedef FilterFunction = Iterable<Word> Function(Iterable<Word>);

FilterFunction exceptFilterFunction(Iterable<Word> except) {
  return (input) {
    return input.where((element) => !except.contains(element));
  };
}

FilterFunction wordLengthCriterion({
  int lengthFrom,
  int lengthTo,
}) {
  lengthFrom = lengthFrom == null ? 0 : lengthFrom;
  lengthTo = lengthTo == null ? int64MaxValue : lengthTo;

  return (input) {
    return input.where((element) {
      final length = element.source.length;
      return length >= lengthFrom && length <= lengthTo;
    });
  };
}

FilterFunction combineFilterFunctions(
  FilterFunction first,
  FilterFunction second,
) {
  return (input) {
    final firstResult = first(input);
    return second(input).removeAll(firstResult).followedBy(firstResult);
  };
}

FilterFunction wordStartsWithCriterion(Pattern pattern) {
  return (input) {
    return input.where((element) => element.source.startsWith(pattern));
  };
}

FilterFunction wordEndsWithCriterion(Pattern pattern) {
  return (input) {
    return input.where((element) => element.source.endsWith(pattern));
  };
}

extension WordsUtils on Iterable<Word> {
  List<Word> getRandomNWords({
    @required Random random,
    int count = 1,
    FilterFunction filter,
    List<FilterFunction> funnelOfCriteria = const [],
  }) {
    // filtering
    Iterable<Word> filtered = filter == null ? this : filter(this);
    if (filtered.length < count) return null;
    if (filtered.length == count) return filtered.toList();

    // find by criteria
    Iterable<Word> lastEligibles = filtered;

    funnelOfCriteria.forEach((criterion) {
      final eligibles = criterion(lastEligibles);

      if (eligibles.length < count) {
        final fromLastEligibles = lastEligibles.getRandomNWords(
          random: random,
          count: count - eligibles.length,
          filter: exceptFilterFunction(eligibles),
        );
        return eligibles.followedBy(fromLastEligibles).toList();
      } else if (eligibles.length == count) {
        return eligibles.toList();
      } else {
        lastEligibles = eligibles;
      }
    });

    return lastEligibles.getRandomN(random, count);
  }

  List<Word> getRandomN(Random random, int count) {
    final asList = this.toList();

    final List<Word> result = [];
    while (result.length < count) {
      final index = random.nextInt(asList.length);
      final candidate = asList[index];
      if (!result.contains(candidate)) {
        result.add(candidate);
      }
    }

    return result;
  }

  Iterable<Word> removeAll(Iterable<Word> toRemove) {
    return where((element) => !toRemove.contains(element));
  }
}
