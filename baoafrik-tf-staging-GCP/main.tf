module "vpc" {
  source              = "./modules/gcp-vpc"
  project             = var.project
  project_id          = var.project_id
  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  region              = var.region
  server_private_ip = module.compute_staging.private_ip
}

module "iam" {
  source         = "./modules/gcp-iam"
  project        = var.project
  staging_bucket = var.staging_bucket_name
  dev_bucket     = var.dev_bucket_name
  network        = module.vpc.network_self_link
}

module "compute_staging" {
  source                = "./modules/gcp-compute"
  project               = var.project
  machine_type          = var.instance_type
  network_self_link     = module.vpc.network_self_link
  subnet_self_link      = module.vpc.public_subnet_self_link
  service_account_email = module.iam.app_service_account_email
}

module "cloudsql" {
  source          = "./modules/gcp-cloudsql"
  project         = var.project
  project_id      = var.project_id
  db_name         = var.db_name
  db_username     = var.db_username
  db_password     = var.db_password
  private_network = module.vpc.network_self_link
  region          = var.region
}

module "storage" {
  source              = "./modules/gcp-cloud-storage"
  project             = var.project
  staging_bucket_name = var.staging_bucket_name
  dev_bucket_name     = var.dev_bucket_name
  prod_domain         = var.prod_domain
  region              = var.region
  service_account_email = module.iam.app_service_account_email
}

module "dns" {
  source         = "./modules/gcp-dns"
  prod_domain    = var.prod_domain
  staging_domain = var.staging_domain
  project        = var.project

  staging_ip_address = module.compute_staging.external_ip
  jenkins_ip_address = module.compute_staging.external_ip
}
