resource "aws_iam_user" "minjae" {
    name = "minjae"
}

resource "aws_iam_user_policy" "art_devops_black" {
  name  = "super-admin"
  user  = aws_iam_user.minjae.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_group" "devops_group" {
    name = "devops"
}

resource "aws_iam_group_policy" "devops_group_policy" {
    name = "devops_group_policy"
    group = aws_iam_group.devops_group.name

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_group_membership" "devops" {
    name = aws_iam_group.devops_group.name

    users = [
        aws_iam_user.minjae.name
    ]

    group = aws_iam_group.devops_group.name
}


resource "aws_iam_role" "hello" {
  name               = "hello-iam-role"
  path               = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "hello_s3" {
  name   = "hello-s3-download"
  role   = aws_iam_role.hello.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowAppArtifactsReadAccess",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
}