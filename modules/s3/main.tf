resource "aws_s3_bucket" "website" {
  bucket = "table-reservations"
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.website.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ownership,
    aws_s3_bucket_public_access_block.public_access,
  ]

  bucket = aws_s3_bucket.website.id
  # acl    = "public-read"
}

resource "aws_s3_object" "website_index" {
  bucket = aws_s3_bucket.website.bucket
  key    = "index.html"
  source = "index.html"
  acl    = "public-read"
}

resource "aws_s3_object" "website_error" {
  bucket = aws_s3_bucket.website.bucket
  key    = "error.html"
  source = "error.html"
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "name" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  depends_on = [ aws_s3_bucket_acl.acl ]
}
