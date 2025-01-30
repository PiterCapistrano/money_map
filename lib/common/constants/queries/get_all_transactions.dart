const String qGetAllTransactions = """
query getAllTransactions {
  transaction(order_by: {date: desc}) {
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
