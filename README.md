# Local TF + Kubernetes Cluster Configuration

This repository contains the configuration files and instructions to set up a local Terraform and Kubernetes cluster using Kind.

## Prerequisites

Before you begin, make sure you have the following prerequisites installed on your machine:

- [Terraform](https://www.terraform.io/downloads.html)
- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)

## Getting Started

To set up the local TF + Kubernetes cluster, follow these steps:

1. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/triozer/tf-local.git
    cd tf-local
    ```

2. Create the cluster

    ```bash
    terraform init # initialize terraform
    terraform plan # plan modules
    terraform apply # create clusters

    kubectl cluster-info --cluster kind-local
    ```
