provider "archive" {
}

data "archive_file" "example_zip_file" {
    type = "zip"
    source_file = "example.py"
    output_path = "local-example.zip"
}

resource "aws_lambda_function" "example_lambda_function" {
    function_name = "example_function"
    filename = data.archive_file.example_zip_file.output_path
    role = aws_iam_role.example_lambda_iam.arn
    handler = "example.lambda_handler"
    runtime = "python3.9"

    tags = {
        project ="hello-lambda"
        scope = "learning"
    }
}