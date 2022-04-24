# terraform_azure_cli

Container for using Terraform and the Azure Cli. Primarily as a possible 'Bitbucket pipelines' build environment (image)

## Notes

1. This image had not yet been uploaded to Docker hub
1. There are no Terraform or Az-Cli packages for anything for Ubuntu 22.04 yet
2. If run on an M1 mac both 'docker build' and 'docker run' require the `--platform linux/x86_64` flag to be used
3. Other ENV variables which could be used with `az login` have not been included yet

## ToDo

1. Use Github actions to build/upload this image to Dockerhub (if possible)
    - https://docs.github.com/en/actions/publishing-packages/publishing-docker-images
2. Pull in specific az environment variables
3. Include a bitbucket-pipelines file to build this as well
    - This may also include the 'push' to docker hub steps
4. Install `jq` as well
5. Pull secret keys for az login from Azure Secrets as part of the build process? Something to 'bake in' access to Azure & run everything? (just an idea...)