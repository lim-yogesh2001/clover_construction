import 'package:clover_construction/models/worker.dart';

class HireGETWorker {
  final int id;
  final Worker worker;
  final DateTime dateOfHire;

  HireGETWorker(
    this.id,
    this.worker,
    this.dateOfHire,
  );
}

class HirePostWorker {
  final int id;
  final int worker;
  final DateTime dateOfHire;
  final int userId;

  HirePostWorker(
    this.id,
    this.worker,
    this.dateOfHire,
    this.userId,
  );
}
