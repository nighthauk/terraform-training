locals {
  staging_version    = akamai_property.tf-scriptclub-property.staging_version != null ? akamai_property.tf-scriptclub-property.staging_version : 1
  production_version = akamai_property.tf-scriptclub-property.production_version != null ? akamai_property.tf-scriptclub-property.production_version : 1
}

resource "akamai_cp_code" "my_sc_cpcode" {
  name        = "Script Club CP Code"
  contract_id = data.akamai_group.my_group_id.contract_id
  group_id    = data.akamai_group.my_group_id.id
  product_id  = "prd_Fresca"
}

resource "akamai_edge_hostname" "my_sc_ehn" {
  product_id = "prd_Fresca"
  contract_id = data.akamai_group.my_group_id.contract_id
  group_id = data.akamai_group.my_group_id.id
  edge_hostname = "tf-scriptclub.test.edgekey.net"
  ip_behavior = "IPV6_COMPLIANCE"
  certificate = 30192
}

resource "akamai_property" "tf-scriptclub-property" {
  name         = "tf-scriptclub"
  product_id   = "prd_Fresca"
  contract_id  = data.akamai_group.my_group_id.contract_id
  group_id     = data.akamai_group.my_group_id.id

  dynamic "hostnames" {
    for_each = local.hostnames
    content {
      cname_from = hostnames.value
      cname_to   = akamai_edge_hostname.my_sc_ehn.edge_hostname
      cert_provisioning_type = "CPS_MANAGED"
    }
  }

  rule_format = data.akamai_property_rules_builder.tf-scriptclub_rule_default.rule_format
  rules = data.akamai_property_rules_builder.tf-scriptclub_rule_default.json
}

resource "akamai_property_activation" "staging_activation" {
  property_id   = akamai_property.tf-scriptclub-property.id
  contact       = ["rhauk@akamai.com"]
  version       = var.activate_latest_on_staging ? akamai_property.tf-scriptclub-property.latest_version : local.staging_version
  network       = "STAGING"
  auto_acknowledge_rule_warnings = true
  note          = local.notes
}

resource "akamai_property_activation" "production_activation" {
  property_id   = akamai_property.tf-scriptclub-property.id
  contact       = ["rhauk@akamai.com"]
  version       = var.activate_latest_on_production ? akamai_property.tf-scriptclub-property.latest_version : local.production_version
  network       = "PRODUCTION"
  note          = local.notes
  auto_acknowledge_rule_warnings = true
  depends_on    = [akamai_property_activation.staging_activation]
  compliance_record {
    noncompliance_reason_no_production_traffic {
      ticket_id = "123"
    }
  }
}
