# Nuxt 3 Blog Starter (with SSR)

Look at the [Nuxt 3 documentation](https://nuxt.com/docs/getting-started/introduction) to learn more.

---

- [Setup](#setup)
- [Development Server](#development-server)
  - [Simulating a Production Server](#simulating-a-production-server)
- [Terraform](#terraform)
  - [Backend](#backend)
  - [Artifacts](#artifacts)
  - [Build out Docker Image](#build-out-docker-image)
  - [Server](#server)
  - [Workload Identity Federation](#workload-identity-federation)

---

## Setup

Make sure to install the dependencies:

```bash
# yarn
yarn install

# npm
npm install

# pnpm
pnpm install
```

## Development Server

Start the development server on `http://localhost:3000`

```bash
npm run dev
```

### Simulating a Production Server

You can simulate a production deployment by building the server and running it locally:

```bash
npm run build && node .output/server/index.mjs
```

You will find the server on `http://localhost:3000`.

## Docker Image

You can run the Docker image locally to test the production server by doing the following (being in the root of the repository):

```bash
docker build . -t ssrblog
docker run -d -p 3000:3000 ssrblog
```

You can visualize the application in `http://localhost:3000`, and if you inspect the network requests, you should see requests for each of the documents once you travel to specific URLs.

## Terraform

This repository uses Terraform to simplify deploying all the infrastructure related to this. Refer to the following sections for instructions on how to deploy every component.

Note that you need the AWS CLI and GCP CLI configured in your environment.

### Backend

_Run this inside `terraform/backend`_

This stack covers creating the bucket that will store all the Terraform state. These are all the commands necessary to deploy the backend bucket that will live in AWS:

```bash
terraform init
terraform plan
terraform apply
export BACKEND_ID=$(terraform output -raw backend_id)
export BACKEND_REGION=$(terraform output -raw backend_region)
```

After you apply this, note the name of the bucket, it should be at the end of the output and look like this. Write it down, it will be useful later on:

```bash
backend_id = "[SITE]--terraform-backend"
```

Note that the last command from the commands block will store the backend ID in a `BACKEND_ID` bash variable.

### Artifacts

_Run this inside `terraform/resources--artifacts`_

This stack creates the artifact registry necessary for the Cloud Run instances to pick up artifacts from:

```bash
terraform init -backend-config="bucket=$BACKEND_ID" -backend-config="region=$BACKEND_REGION"
terraform plan
terraform apply
export REGISTRY_LOCATION=$(terraform output -raw registry_location)
export REGISTRY_NAME=$(terraform output -raw registry_name)
export PROJECT_ID=$(terraform output -raw gcp_project_id)
```

### Build out Docker Image

_Run this inside `terraform`_

This part is how to build and push the Docker image into the registry (more info [here](https://cloud.google.com/artifact-registry/docs/docker/pushing-and-pulling)):

```bash
SSR_IMAGE="ssr-site"
export IMAGE_URI="$REGISTRY_LOCATION-docker.pkg.dev/$PROJECT_ID/$REGISTRY_NAME/$SSR_IMAGE"
export REGISTRY_URI="$REGISTRY_LOCATION-docker.pkg.dev"
gcloud auth configure-docker $REGISTRY_LOCATION-docker.pkg.dev
(cd .. && docker build --platform linux/amd64 -t $IMAGE_URI . && docker push $IMAGE_URI)
```

If you have issues building the Docker image, removing `node_modules` and `package-lock.json` and re-running `npm i` works.

### Server

_Run this inside `terraform/resources--server`_

This stack creates the artifact registry necessary for the Cloud Run instances to pick up artifacts from:

```bash
terraform init -backend-config="bucket=$BACKEND_ID" -backend-config="region=$BACKEND_REGION"
terraform plan -var="image=$IMAGE_URI"
terraform apply -var="image=$IMAGE_URI"
```

### Workload Identity Federation

_Run this inside `terraform/resources--wif`_

This stack creates the WIF resources necessary for GitHub Actions to authenticate with the SA:

```bash
terraform init -backend-config="bucket=$BACKEND_ID" -backend-config="region=$BACKEND_REGION"
terraform plan
terraform apply

```
