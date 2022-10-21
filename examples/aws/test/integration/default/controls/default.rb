# frozen_string_literal: true
# Inspec::InputRegistry.instance.cache_inputs = false

# copyright: 2022, Rearc LLC

title 'Example Section'

# terraform_workspace = input('terraform_workspace')
# aws_region = input('region')
# virtual_private_cloud = input('vpcs')

control 'aws-virtual-network' do
  impact 1.0
  title 'Inspect Virtual Private Clouds' # A human-readable title
  describe aws_vpc( vpc_id: 'vpc-deadbeef' ) do
    it { should_not exist }
  end
end
