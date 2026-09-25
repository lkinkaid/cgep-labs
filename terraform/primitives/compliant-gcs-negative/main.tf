# Step 7: The negative test

# terraform/primitives/compliant-gcs-negative/main.tf  (module block; also include provider + outputs from Step 4)
module "data_bucket" {
  source = "../../modules/compliant-gcs-bucket"

  gcp_project        = "superb-ship-509617-c1"
  project_label      = "cgep-lab"
  environment        = "prod"
  retention_days     = 30   # FAILS: prod requires >= 365
  bucket_name_suffix = "should-never-exist"
}