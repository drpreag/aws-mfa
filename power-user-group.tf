
resource "aws_iam_group_policy_attachment" "power_user_general_policy" {
  group      = aws_iam_group.power_users.id
  policy_arn = aws_iam_policy.power_user_general_policy.arn
}

resource "aws_iam_group_policy_attachment" "billing_to_power_users" {
  group      = aws_iam_group.power_users.id
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}

resource "aws_iam_policy" "power_user_general_policy" {
  name = local.power_user_general_policy
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*",
          "ec2:*",
          "rds:*",
          "ecr:*",
          "elasticloadbalancing:*",
          "eks:*",
          "ebs:*",
          "iam:*",
          "glacier:*",
          "kms:*",
          "lambda:*",
          "route53:*",
          "route53domains:*",
          "route53-recovery-readiness:*",
          "route53-recovery-control-config:*",
          "ses:*",
          "sns:*",
          "sts:*",
          "sqs:*",
          "logs:*",
          "autoscaling:*",
          "cloudwatch:*",
          "access-analyzer:*"
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
          "*",
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
