output "rendered" {
  value       = "${data.ignition_config.users.rendered}"
  description = "Rendered ignition configuration. See README for usage."
}
