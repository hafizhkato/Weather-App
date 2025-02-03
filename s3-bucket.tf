#create s3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "kerinci-weather-app"
  
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

#s3 bucket policy
resource "aws_s3_bucket_policy" "s3_public_access" {
  bucket = aws_s3_bucket.bucket.id
  policy = templatefile("${path.module}/policies/s3-policy.json.tpl", {
    s3_arn = aws_s3_bucket.bucket.arn
  })
}

#enable or disabled public access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# specify default page for the website
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }
}

#upload file to s3 bucket
resource "aws_s3_object" "website-file" {
  for_each = fileset("${path.module}/source", "**")  # Upload all files in "source" folder

  bucket = aws_s3_bucket.bucket.id
  key    = each.value
  source = "${path.module}/source/${each.value}"
  content_type = lookup({
    html = "text/html"
    css  = "text/css"
    js   = "application/javascript"
  }, split(".", each.value)[length(split(".", each.value)) - 1], "application/octet-stream")
  
}