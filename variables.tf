variable "team_slug" {
  description = "github team slug"
}

variable "groups" {
  description = "users to be added to these groups (coreos and docker by default)"
  default     = ["coreos", "docker"]
}
