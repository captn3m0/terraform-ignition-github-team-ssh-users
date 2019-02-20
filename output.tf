output "rendered" {
  value       = "${data.ignition_config.users.rendered}"
  description = "Rendered ignition configuration. See README for usage."
}

output "source" {
  description = "Ready data-uri based source to inser into a append or replace block"
  value       = "data:text/plain;charset=utf-8;base64,${base64encode(data.ignition_config.users.rendered)}"
}

output "verification" {
  description = "Verification hash for the userdata"
  value       = "sha512-${sha512(data.ignition_config.users.rendered)}"
}
