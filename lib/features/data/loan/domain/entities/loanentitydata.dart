import 'package:bekkams_lending/corecomponents/enums/loanenums.dart';

class LoanEntity {
  final String loanId;
  final String userId;
  final double loanAmount;
  final double interestRate;
  final InterestType interestType;
  final double totalPayableAmount;
  final int tenureMonths;
  final double emiAmount;
  final PaymentFrequency paymentFrequency;
  final DateTime loanStartDate;
  final DateTime loanEndDate;
  final LoanStatus loanStatus;
  final double principalOutstanding;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LoanEntity({
    required this.loanId,
    required this.userId,
    required this.loanAmount,
    required this.interestRate,
    required this.interestType,
    required this.totalPayableAmount,
    required this.tenureMonths,
    required this.emiAmount,
    required this.paymentFrequency,
    required this.loanStartDate,
    required this.loanEndDate,
    required this.loanStatus,
    required this.principalOutstanding,
    required this.createdAt,
    required this.updatedAt,
  });
}
