resource "aws_s3_bucket" "staging_bucket" {
  bucket = var.staging_bucket

  tags = {
    Name = var.staging_bucket
  }
}
resource "aws_s3_bucket" "dev_bucket" {
  bucket = var.dev_bucket

  tags = {
    Name = var.dev_bucket
  }
}

resource "aws_s3_bucket_public_access_block" "staging_public_access" {
  bucket = aws_s3_bucket.staging_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_public_access_block" "dev_public_access" {
  bucket = aws_s3_bucket.dev_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_cors_configuration" "staging_uploads" {
  bucket = aws_s3_bucket.staging_bucket.id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    allowed_origins = [
      "https://staging.baoafrik.com",
      "https://www.staging.baoafrik.com",
    ]
    expose_headers  = ["ETag", "x-amz-request-id"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_cors_configuration" "dev_uploads" {
  bucket = aws_s3_bucket.dev_bucket.id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    allowed_origins = [
      "http://localhost:3000",
      "http://localhost:3001"
    ]
    expose_headers  = ["ETag", "x-amz-request-id"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_policy" "staging_bucket_policy" {
  bucket     = aws_s3_bucket.staging_bucket.id
  depends_on = [aws_s3_bucket_public_access_block.staging_public_access]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowPublicRead"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.staging_bucket.arn}/*"
      },
      {
        Sid       = "AllowUploads"
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:DeleteObject",
        ]
        Resource = "${aws_s3_bucket.staging_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "dev_bucket_policy" {
  bucket = aws_s3_bucket.dev_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowAll"
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:DeleteObject"
        ]
        Resource = "${aws_s3_bucket.dev_bucket.arn}/*"
      }
    ]
  })
}