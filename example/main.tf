module "moonswitch-sso" {
  source            = "../"
  saml_metadata_url = var.saml_metadata_url
}