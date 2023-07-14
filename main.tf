data "http" "getfile" {
  url = var.saml_metadata_url
}

resource "aws_iam_saml_provider" "this" {
  name                   = "MoonswitchOktaIDP"
  saml_metadata_document = data.http.getfile.response_body
}

data "aws_iam_policy_document" "trust_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithSAML"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_saml_provider.this.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "SAML:aud"

      values = ["https://signin.aws.amazon.com/saml"]
    }
  }
}

resource "aws_iam_role" "admin" {
  name               = "MoonswitchAdministratorAccessRole"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
}

resource "aws_iam_role_policy_attachment" "admin" {
  role       = aws_iam_role.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role" "poweruser" {
  name               = "MoonswitchPowerUserAccessRole"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
}

resource "aws_iam_role_policy_attachment" "poweruser" {
  role       = aws_iam_role.poweruser.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_role" "readonly" {
  name               = "MoonswitchReadOnlyAccessRole"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
}

resource "aws_iam_role_policy_attachment" "readonly" {
  role       = aws_iam_role.readonly.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}