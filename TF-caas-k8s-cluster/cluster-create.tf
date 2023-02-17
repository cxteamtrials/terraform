terraform {
  required_providers {
    hpegl = {
      source = "HPE/hpegl"
      version = "0.3.13"
    }
  }
}
 
provider "hpegl" {
  caas {
    api_url = ""
  }
}

variable "HPEGL_SPACE" {
  type = string
  default = "Default"
}

data "hpegl_caas_site" "blr" {
  name     = ""
  space_id = var.HPEGL_SPACE
}

data "hpegl_caas_cluster_blueprint" "bp" {
  name    = "g2ie-standard"
  site_id = data.hpegl_caas_site.blr.id
}


resource "hpegl_caas_cluster" "cx-emam-test" {
  name         = "tf-cx-emam-test"
  blueprint_id = data.hpegl_caas_cluster_blueprint.bp.id
  site_id      = data.hpegl_caas_site.blr.id
  space_id     = var.HPEGL_SPACE


}
