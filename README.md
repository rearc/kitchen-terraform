# Kitchen Terraform
This project is a tool for working with [kitchen-terraform](https://newcontext-oss.github.io/kitchen-terraform/), which is a plugin for [test kitchen](https://kitchen.ci/). It provides a container for running kitchen and examples of various tests. By using this tool we can validate our IaC before we actually consume it, this is very valuable for building trust in our tools.


## Resources
  * [Test Kitchen](https://kitchen.ci/docs/getting-started/introduction/): Integration test automation
  * [Inspec](https://docs.chef.io/inspec/): IaC integration test framework, uses a DSL similar to [rspec](https://rspec.info/)
  * [Kitchen Terraform](https://newcontext-oss.github.io/kitchen-terraform/): Plugin for Test Kitchen to able testing of Terraform, allows for the automated apply and destruction of terraform modules, it further supports passing the output of the terraform module to the test suite
  * [AWS Inspec Resources](https://docs.chef.io/inspec/resources/#aws): The list of resources and their attributes you can use to write tests
  * [Inspec Profile](https://docs.chef.io/inspec/profiles/): Defines at an inspec test suite, for example the "platform" that the tests apply to, or any depencies the tests may require
  * [Test Kitchen Configuration File (kitchen.yml)](https://docs.chef.io/workstation/config_yml_kitchen/): The configuration file for automating Inspec tests, as well as execuating IaC

## Examples
All the examples assume you have built the kitchen-terraform container image with a tag of test. You could replicate the setup on your workstation as well, but why?

>All examples come with a script which allows you to run the example with minimal effort. Please read the script to see which envrionment variables you need to set.


 * AWS, builds a VPC. The VPC is pretty basic and uses the [VPC module from the Terraform Registry](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest). It will build a VPC in three Availability Zones and create three subnets. It's a rather simple setup and closely matches the simple VPC example from the registry module.

 * Docker, build a docker image and instantiates it. The container is configured to serve an SSH server and allow for 'remote connections'. In order to build the container the kitchen-terraform container will need have the host's docker socket mounted inside it, this is known as docker on docker or docker in docker.

    The test will automate connecting to the instantiated container over SSH and checks to ensure that the host OS reports as being Ubuntu.
