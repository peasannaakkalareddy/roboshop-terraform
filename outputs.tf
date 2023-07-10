output "vpc" {
  value = lookup(module.vpc, "main", null)
}
