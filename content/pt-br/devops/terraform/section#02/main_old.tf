# aws_iam_openid_connect_provider.default:
resource "aws_iam_openid_connect_provider" "default" {
  arn = "arn:aws:iam::008736932128:oidc-provider/token.actions.githubusercontent.com"
  client_id_list = [
    "sts.amazonaws.com",
  ]
  id       = "arn:aws:iam::008736932128:oidc-provider/token.actions.githubusercontent.com"
  tags_all = {}
  thumbprint_list = [
    "1b511abead59c6ce207077c0bf0e0043b1382612",
  ]
  url = "token.actions.githubusercontent.com"
}

# aws_iam_policy_attachment.role_oidc_policy_attachment:
resource "aws_iam_policy_attachment" "role_oidc_policy_attachment" {
  groups = [
    "AdministratorAccess",
  ]
  id         = "Policy Attachement"
  name       = "Policy Attachement"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  roles = [
    "github-repo-736769668",
  ]
}

# aws_iam_role.role_oidc:
resource "aws_iam_role" "role_oidc" {
  arn = "arn:aws:iam::008736932128:role/github-repo-736769668"
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRoleWithWebIdentity"
          Condition = {
            StringEquals = {
              "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
            }
            StringLike = {
              "token.actions.githubusercontent.com:sub" = "repo:kumabes-org/infra-aws-ec2:*"
            }
          }
          Effect = "Allow"
          Principal = {
            Federated = "arn:aws:iam::008736932128:oidc-provider/token.actions.githubusercontent.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  create_date           = "2023-12-28T23:44:54Z"
  force_detach_policies = false
  id                    = "github-repo-736769668"
  managed_policy_arns   = []
  max_session_duration  = 3600
  name                  = "github-repo-736769668"
  path                  = "/"
  tags_all              = {}
  unique_id             = "AROAQECGDAEQHKRGXNENE"
}
