Terraform AWS Multi Account Setup
=================================

This repo relates to the [medium blog article here](https://medium.com/@benlu/a-sensible-devops-org-level-multi-account-aws-setup-with-terraform-b8905607870b)

As per terraform, make sure you cd in to a directory then run

```terraform
terraform init
terraform apply
```

The examples provided will not work out of the box as they use fake account and email addresses and chicken and egg issues of requiring infra to use infra. Details below.

Repo Structure
--------------
### tf_backend
This is where we store our terraform backend (bucket plus dynamodb for locking). To get it to work:

1. Change the bucket name in the backend.tf and in the main.tf
2. Make sure this change also is reflected in your org folder
3. Comment out the backend, file, apply it, then uncomment it and reapply it, letting terraform copy state over as it should notice

### modules
This is where reusable code goes

### org
This is where the primary setup is for the org. You probably want to follow the blog article, and comment out most of the code and uncomment as you go as some resources are dependent on things like accounts being setup. Make sure you've setup your backend first.

