resource "aws_s3_bucket" "prod_bucket" {
  bucket = var.prod_bucket

  tags = {
    Name = var.prod_bucket
  }
}

resource "aws_s3_bucket_public_access_block" "prod_public_access" {
  bucket = aws_s3_bucket.prod_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_cors_configuration" "prod_uploads" {
  bucket = aws_s3_bucket.prod_bucket.id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    allowed_origins = [
      "https://baoafrik.com",
      "https://www.baoafrik.com",
    ]
    expose_headers  = ["ETag", "x-amz-request-id"]
    max_age_seconds = 3000
  }
}


resource "aws_s3_bucket_policy" "prod_bucket_policy" {
  bucket     = aws_s3_bucket.prod_bucket.id
  depends_on = [aws_s3_bucket_public_access_block.prod_public_access]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowPublicRead"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.prod_bucket.arn}/*"
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
        Resource = "${aws_s3_bucket.prod_bucket.arn}/*"
      }
    ]
  })
}
