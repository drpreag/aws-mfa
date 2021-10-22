
resource "aws_iam_group_policy_attachment" "admin_general_policy" {
  group      = aws_iam_group.administrators.id
  policy_arn = aws_iam_policy.admin_general_policy.arn
}

resource "aws_iam_group_policy_attachment" "billing_to_admins" {
  group      = aws_iam_group.administrators.id
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}

resource "aws_iam_policy" "admin_general_policy" {
  name = local.admin_general_policy
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "*"
        ],
        "Resource" : "*",
        "Condition" : {
          "Bool" : {
            "aws:MultiFactorAuthPresent" : "true"
          }
        }
      },
      {
        "Effect" : "Deny",
        "Action" : [
          "*"
        ],
        "Resource" : "*",
        "Condition" : {
          "Bool" : {
            "aws:MultiFactorAuthPresent" : "false"
          }
        }
      }
    ]
  })
}
