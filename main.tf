data "github_team" "team" {
  slug = "${var.team_slug}"
}

data "github_user" "user" {
  count    = "${length(data.github_team.team.members)}"
  username = "${data.github_team.team.members[count.index]}"
}

data "ignition_user" "user" {
  count               = "${length(data.github_team.team.members)}"
  name                = "${lower(element(data.github_user.user.*.login, count.index))}"
  home_dir            = "/home/${lower(element(data.github_user.user.*.login, count.index))}"
  shell               = "/bin/bash"
  ssh_authorized_keys = ["${data.github_user.user.*.ssh_keys[count.index]}"]
  groups              = ["${var.groups}"]
}

data "ignition_config" "users" {
  users = ["${data.ignition_user.user.*.id}"]
}
