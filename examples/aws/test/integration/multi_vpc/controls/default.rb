# frozen_string_literal: true
# Inspec::InputRegistry.instance.cache_inputs = false

# copyright: 2022, Rearc LLC

terraform_workspace = input('terraform_workspace')
aws_region = input('region')
virtual_private_cloud = input('vpcs')

control 'aws-virtual-network' do
  impact 1.0
  title 'Inspect Virtual Private Clouds' # A human-readable title

  virtual_private_cloud.each do |_, vpc|
    describe aws_vpc( aws_region: aws_region, vpc_id: vpc[:vpc_id] ) do
      it { should exist }
      it { should be_available }
      it { should_not be_default }
      its('cidr_block') { should cmp vpc[:vpc_cidr_block] }
      its('tags') { should include( "Kitchen" => 'True', "Workspace" => terraform_workspace ) }
    end
    aws_regions.region_names.each do | region |
      describe aws_vpcs( aws_region: region ) do
        if region == aws_region
          its('vpc_ids') { should include(vpc[:vpc_id]) }
        else
          its('vpc_ids') { should_not include(vpc[:vpc_id]) }
        end
      end
    end
  end
end
include_controls 'default'
include_controls 'inspec-aws'
