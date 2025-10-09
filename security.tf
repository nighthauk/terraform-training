resource "akamai_appsec_configuration" "my_new_appsec_config" {
    name = "csgt-v2"
    group_id = "299415"
    description = "CSGT AppSec Config v2"
    contract_id = "data.akamai_group.my_group_id.contract_id"
    host_names = [ "js-scriptclub.test.edgekey.net" ]
}

resource "akamai_appsec_security_policy" "my_new_appsec_policy" {
    config_id = akamai_appsec_configuration.my_new_appsec_config.id
    security_policy_name = "my-scriptclub-policy"
    security_policy_prefix = "abc"
}

resource "akamai_appsec_security_policy" "my_new_appsec_policy_2" {
    config_id = akamai_appsec_configuration.my_new_appsec_config.id
    security_policy_name = "my-scriptclub-policy-2"
    security_policy_prefix = "abcd"
}