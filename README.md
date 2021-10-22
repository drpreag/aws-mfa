# MFA-protected API access
# or...
# access key / secret access key with MFA

## Purpose:

Protects aws account from using API calls through access keys without MFA, almost same way that console access is protected with MFA.

I got idea here: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa_configure-api-require.html.
For aws-mfa script i got idea here: https://github.com/broamski/aws-mfa

## How ?

It creates:

- user groups:
    - admin-group
    - power-user-group
- iam policies:
    - admin-general-policy (policy which enforces MFA for API calls)
    - power-user-general-policy (policy which enforces MFA for API calls)
- iam account password policy

You can modify repo to add more low power groups with same principal that group's policy is enforcing MFA. Make sure every user in your aws account belongs to a group with enforced MFA group policy.

## Steps

- Make settings in repo files:
    - set up variables in parameters.tf
    - set up s3 bucket for tf state in terraform.tf (or set it localy)
- Set MFA at your own account, or you want be abble to access resource after terraform apply.
- Get your own access key/secret access key and put them in `[long-term]` section in `.~/.aws/credentials`.
  Without MFA active this key/secret will be low power... and can only be used with MFA code to create new session.
- Run

    `terraform init`

    `terraform plan`

    `terraform apply`

  to make changes over your aws account.
- Put your user into admin-group group.
- Put `aws-mfa` script somewhere in your path, make it executable and run it. This script uses yor `[long-term]` keys and MFA code to retrieve temporary keys and token for 12 hour session. All this is stored in `[default]` section so you can run aws cli commands without setting a profile.
- Test:
  Try this command to access resources:

  `aws s3 ls`

  This one should produce access error, since MFA is not raised over that key:

  `aws s3 ls --profile long-term`
