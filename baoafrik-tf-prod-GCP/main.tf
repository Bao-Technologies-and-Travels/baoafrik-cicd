module "vpc" {
  source              = "./modules/gcp-vpc"
  project             = var.project
  project_id          = var.project_id
  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  region              = var.region
}

module "iam" {
  source      = "./modules/gcp-iam"
  project     = var.project
  prod_bucket = var.prod_bucket_name
  network     = module.vpc.network_self_link
}

module "compute_prod" {
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
  source           = "./modules/gcp-cloud-storage"
  project          = var.project
  prod_bucket_name = var.prod_bucket_name
  prod_domain      = var.prod_domain
  region           = var.region
}

module "dns" {
  source      = "./modules/gcp-dns"
  prod_domain = var.prod_domain

  prod_ip_address    = module.compute_prod.external_ip
  jenkins_ip_address = module.compute_prod.external_ip
  staging_project = var.staging_project
}
