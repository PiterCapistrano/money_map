const String qGetAllTransactions = """
Query getAllTransactions {
  transction {
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
