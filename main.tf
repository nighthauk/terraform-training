data "akamai_group" "my_group_id" {
  group_name = "Script Club"
  contract_id = "1-5C13O2"
}

output "my_group_id" {
  value = data.akamai_group.my_group_id
}

data "akamai_property" "my_property" {
  name = "js-scriptclub"
}

output "my_property" {
  value = data.akamai_property.my_property
}


