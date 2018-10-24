Terraform ECE
===========
Scripts to launch [ECE](https://www.elastic.co/products/ece) on [AWS EC2](https://aws.amazon.com/ec2/) using [terraform](https://www.terraform.io/).

Quick Start
===========

Prerequisites
-----------
* Terraform

* AWS cli and MFA installed


How to use
--------

#### Initialize environment variables using MFA 6-digit code

``` bash
source init.sh 
make init
```

#### Launch EC2 instance and install ECE

``` bash
make apply
make install
make ssh
```

#### Destroy and clean environment

``` bash
make destroy
make clean
```