resource "aws_iam_group" "administrators" {
  name = local.admin_group_name
}

resource "aws_iam_group" "power_users" {
  name = local.power_user_group_name
}