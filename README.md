# terraform-ignition-github-team-ssh-users

Generate a ignition config to create multiple users from a github team. SSH Keys for all users are picked up from GitHub. This can be used to automate creation of user accounts on your servers by using their SSH keys that are already pushed to GitHub.

The user list is picked up by taking a github team under the organization.

The flow is:

```
INPUT         -> -------- -> OUTPUT
[GitHub Team] -> [Module] -> [Ignition config]
```

See the module input and output variables at either [Terraform Registry][reg] or [MODULES.md](MODULES.md)

# Usage

```hcl
module "ignition" {
	source    = "captn3m0/github-team-ssh-users/ignition"
	version   = "1.0.0"
	team_slug = "sshusers"
}

resource "aws_s3_bucket_object" "s3" {
	key     = "users.json"
	bucket  = "ignition-bucket"
	content = "${module.ignition.rendered}"
}

data "ignition_config" {
	// Rest of your config goes here
	systemd = []
	// Append these users to the config
	append {
		source       = "s3://${aws_s3_bucket_object.bucket}/${aws_s3_bucket_object.key}"
		verification = "sha512-${sha512(module.ignition.rendered)}"
	}
}

provider "github" {
	token        = "${var.github_token}"
	organization = "your-organization-name"
}
```

# License

Licensed under the [MIT License](https://nemo.mit-license.org/). See LICENSE file for details.
Copyright 2019 Abhay Rana

[reg]: https://registry.terraform.io/modules/captn3m0/github-team-ssh-users/ignition/
