terraform {
  backend "gcs" {
    bucket = "tf-gcp-test-123-dev"
    prefix = "env/dev"
  }
}
