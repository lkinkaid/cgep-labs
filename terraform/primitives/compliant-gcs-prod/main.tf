#Step 5: Write the prod consumer (plan only)

# terraform/primitives/compliant-gcs-prod/main.tf  (module block; also include provider + outputs from Step 4)
module "data_bucket" {
  source = "../../modules/compliant-gcs-bucket"

  gcp_project        = "superb-ship-509617-c1"
  project_label      = "cgep-lab"
  environment        = "prod"
  retention_days     = 365
  bucket_name_suffix = "prod-data-LRK"   # use your personal suffix, e.g. prod-data-<your-initials>
}