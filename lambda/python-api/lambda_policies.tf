data "aws_iam_policy_document" "example_lambda_policy" {
    statement {
      sid = "examplePolicyId"
      effect = "Allow"
      principals {
        identifiers = ["lambda.amazonaws.com"]
        type = "Service"
      }
      actions = ["sts:AssumeRole"]
    }
}

resource "aws_iam_role" "example_lambda_iam" {
    name = "example_lambda_iam"
    assume_role_policy = data.aws_iam_policy_document.example_lambda_policy.json
}