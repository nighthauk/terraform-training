data "akamai_property_rules" "sc_tf_rules" {
  property_id = data.akamai_property.my_property.property_id
  version     = data.akamai_property.my_property.latest_version
}

output "my_property_rules" {
    value = data.akamai_property_rules.sc_tf_rules
}