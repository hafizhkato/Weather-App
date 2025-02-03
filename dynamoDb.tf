resource "aws_dynamodb_table" "search_history" {
  name         = "LocationData"
  billing_mode = "PAY_PER_REQUEST"  # On-demand pricing (no need to specify read/write capacity)

  hash_key  = "location"
  range_key = "timestamp"  # Sort key for time-based queries

  attribute {
    name = "location"
    type = "S"  # String
  }

  attribute {
    name = "timestamp"
    type = "S"  # String (ISO8601 format: YYYY-MM-DDTHH:MM:SSZ)
  }

  ttl {
    attribute_name = "ttl"  # Auto-delete expired items (optional)
    enabled        = true
  }

  tags = {
    Name = "UserSearchHistory"
    Env  = "Dev"
  }
}