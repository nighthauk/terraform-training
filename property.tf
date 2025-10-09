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
  ip_behavior = "IPV4"
  certificate = 30192
}

resource "akamai_property" "tf-scriptclub-property" {
  name         = "tf-scriptclub"
  product_id   = "prd_Fresca"
  contract_id  = data.akamai_group.my_group_id.contract_id
  group_id     = data.akamai_group.my_group_id.id

  hostnames {
    cname_from = "tf-scriptclub.test.edgekey.net"
    cname_to   = akamai_edge_hostname.my_sc_ehn.edge_hostname
    cert_provisioning_type = "CPS_MANAGED"
  }

  rule_format = "v2025-09-09"
  rules = data.akamai_property_rules.sc_tf_rules.rules
}