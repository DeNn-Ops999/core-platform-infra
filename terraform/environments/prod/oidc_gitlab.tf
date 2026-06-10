# GitLab OIDC Identity Provider for keyless CI/CD authentication
resource "aws_iam_openid_connect_provider" "gitlab" {
  url             = "https://gitlab.com"
  client_id_list  = ["https://gitlab.com"]
  thumbprint_list = ["b3dd7606d2b5a8b4a13771dbecc9ee1cecafa38a"]
}

# Strict trust policy: allow AssumeRole ONLY from the 'main' branch of the infra repository
data "aws_iam_policy_document" "gitlab_ci_trust" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.gitlab.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "gitlab.com:sub"
      values   = ["project_path:velofreight/core-platform-infra:ref_type:branch:ref:main"]
    }
  }
}

resource "aws_iam_role" "gitlab_ci_deployer" {
  name                 = "kumoscale-prod-gitlab-ci-deployer"
  assume_role_policy   = data.aws_iam_policy_document.gitlab_ci_trust.json
  max_session_duration = 3600
}
