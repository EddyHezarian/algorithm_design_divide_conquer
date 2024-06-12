Map<String, dynamic>? findBestPackaging(
  int N, List<int> packageSizes, int M, List<List<int>> boxSizes) {
  int minEmptySpace = 10000000;
  List<List<int>>? pairs;
  packageSizes.sort();

  for (int i = 0; i < M; i++) {
    List<int> boxes = boxSizes[i];
    boxes.sort();

    var result = divideAndConquer(packageSizes, boxes);

    if (result != null && result['totalEmptySpace'] < minEmptySpace) {
      minEmptySpace = result['totalEmptySpace'];
      pairs = result['pairs'];
    }
  }

  if (pairs == null) {
    return null;
  } else {
    return {
      'totalEmptySpace': minEmptySpace,
      'pairs': pairs,
    };
  }
}

Map<String, dynamic>? divideAndConquer(List<int> packages, List<int> boxes) {
  if (packages.isEmpty) {
    return {'totalEmptySpace': 0.0, 'pairs': <List<double>>[]};
  }

  int n = packages.length;
  if (n == 1) {
    int? box = boxes.firstWhere((b) => b >= packages[0], orElse: () => -1);
    if (box == -1) return null;
    return {
      'totalEmptySpace': box - packages[0],
      'pairs': [
        [packages[0], box]
      ]
    };
  }

  int mid = n ~/ 2;
  var leftPackages = packages.sublist(0, mid);
  var rightPackages = packages.sublist(mid);

  var leftResult = divideAndConquer(leftPackages, boxes);
  var rightResult = divideAndConquer(rightPackages, boxes);

  if (leftResult == null || rightResult == null) return null;

  return {
    'totalEmptySpace':
        leftResult['totalEmptySpace'] + rightResult['totalEmptySpace'],
    'pairs': leftResult['pairs'] + rightResult['pairs'],
  };
}

computeBestPackagingCost(int lengthOfPackages, int lengthOfBoxes,
    List<List<int>> boxSizes, List<int> packageSizes) {
  var result = findBestPackaging(
      lengthOfPackages, packageSizes, lengthOfBoxes, boxSizes);

  if (result == null) {
    List<String>msg =["NO SOLUTION FOUND"];
    return msg;
  } else {
    List<String> response = [];
    response.add(result['totalEmptySpace'].toString());
    for (var pair in result['pairs']) {
      response.add('${pair[0]} ${pair[1]}');
    }
    return response;
  }
}
