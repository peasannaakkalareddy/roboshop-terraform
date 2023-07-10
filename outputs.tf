output "vpc" {
  value = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnet_ids", null)
}
#  subnet_id     = element(lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnets", null), each.value["subnet_name"], null), "subnet_ids", null), 0)
#}
//element(lookup(lookup(module.vpc, each.value["subnet_name"], null), "subnet_ids", null), 0)