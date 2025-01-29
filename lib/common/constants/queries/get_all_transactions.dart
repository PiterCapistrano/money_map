const String qGetAllTransactions = """
query getAllTransactions {
  transaction {
    category
    created_at
    description
    date
    id
    status
    user_id
    value
  }
}
""";
