terraform {
  backend "gcs" {
    bucket = "tf-gcp-test-123-prod"
    prefix = "env/prod"
  }
}
