resource "akamai_dns_record" "tf_sc_dns_record" {
    count       = length(var.apps)
    zone        = "scriptclub.net"
    recordtype  = "TXT"
    target      = ["akamai-validation-${local.hostnames[count.index]}=abcdef1234567890"]
    name        = replace(element(var.apps, count.index), "-scriptclub", ".scriptclub.net")
    ttl         = 300
}

resource "akamai_dns_record" "tf_dns_records" {
  for_each = var.dns_records
 
  zone       = "scriptclub.net"
  recordtype = each.value.recordType
  ttl        = each.value.ttl
  target     = [each.value.target]
  name       = each.value.name
}