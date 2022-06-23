terraform {
  backend "s3" {
    bucket = "kavitha-tests-bucket"
    key    = "demo-statefile"
    region = "us-east-1"
  }
}
