resource "aws_dynamodb_table" "reservations" {
  name           = "reservations"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "reservation_id"
  range_key      = "reservation_date"

  attribute {
    name = "reservation_id"
    type = "S"
  }

  attribute {
    name = "reservation_date"
    type = "S"
  }

  global_secondary_index {
    name               = "reservation_date_index"
    hash_key           = "reservation_date"
    projection_type    = "ALL"
    read_capacity      = 5
    write_capacity     = 5
  }

  ttl {
        attribute_name = "TimeToLive"
        enabled        = true
    }

    tags = {
        Name = "ReservationsTable"
    }

}
