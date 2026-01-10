import 'package:bekkams_lending/corecomponents/enums/loanenums.dart';
import 'package:bekkams_lending/features/data/loan/domain/entities/loanentitydata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoanModel extends LoanEntity {
  const LoanModel({
    required super.loanId,
    required super.userId,
    required super.loanAmount,
    required super.interestRate,
    required super.interestType,
    required super.totalPayableAmount,
    required super.tenureMonths,
    required super.emiAmount,
    required super.paymentFrequency,
    required super.loanStartDate,
    required super.loanEndDate,
    required super.loanStatus,
    required super.principalOutstanding,
    required super.createdAt,
    required super.updatedAt,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json, String docId) {
    return LoanModel(
      loanId: docId,
      userId: json['userId'],
      loanAmount: (json['loanAmount'] as num).toDouble(),
      interestRate: (json['interestRate'] as num).toDouble(),
      interestType: InterestType.values.byName(json['interestType']),
      totalPayableAmount: (json['totalPayableAmount'] as num).toDouble(),
      tenureMonths: json['tenureMonths'],
      emiAmount: (json['emiAmount'] as num).toDouble(),
      paymentFrequency: PaymentFrequency.values.byName(
        json['paymentFrequency'],
      ),
      loanStartDate: (json['loanStartDate'] as Timestamp).toDate(),
      loanEndDate: (json['loanEndDate'] as Timestamp).toDate(),
      loanStatus: LoanStatus.values.byName(json['loanStatus']),
      principalOutstanding: (json['principalOutstanding'] as num).toDouble(),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'loanAmount': loanAmount,
      'interestRate': interestRate,
      'interestType': interestType.name,
      'totalPayableAmount': totalPayableAmount,
      'tenureMonths': tenureMonths,
      'emiAmount': emiAmount,
      'paymentFrequency': paymentFrequency.name,
      'loanStartDate': Timestamp.fromDate(loanStartDate),
      'loanEndDate': Timestamp.fromDate(loanEndDate),
      'loanStatus': loanStatus.name,
      'principalOutstanding': principalOutstanding,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory LoanModel.fromEntity(LoanEntity entity) {
    return LoanModel(
      loanId: entity.loanId,
      userId: entity.userId,
      loanAmount: entity.loanAmount,
      interestRate: entity.interestRate,
      interestType: entity.interestType,
      totalPayableAmount: entity.totalPayableAmount,
      tenureMonths: entity.tenureMonths,
      emiAmount: entity.emiAmount,
      paymentFrequency: entity.paymentFrequency,
      loanStartDate: entity.loanStartDate,
      loanEndDate: entity.loanEndDate,
      loanStatus: entity.loanStatus,
      principalOutstanding: entity.principalOutstanding,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
