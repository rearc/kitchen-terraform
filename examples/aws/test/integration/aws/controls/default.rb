# frozen_string_literal: true

# copyright: 2022, Rearc LLC

title 'Example Section'

terraform_workspace = input('terraform_workspace')
virtual_private_cloud = input('vpcs')

control 'aws-virtual-network' do
  impact 1.0
  title 'Inspect Virtual Private Clouds' # A human-readable title
  describe aws_vpc( vpc_id: virtual_private_cloud[:vpc_id] ) do
    it { should exist }
    its('cidr_block') { should cmp virtual_private_cloud[:vpc_cidr_block] }
  end
  #describe aws_vpcs() do
  #  its('count') { should cmp virtual_private_cloud.length }
  #end
  # virtual_network.each do |_, vnet|
  #   describe azure_virtual_network(resource_group: resource_group['name'], name: vnet[:vnet_name]) do
  #     it { should exist }
  #     its('id') { should cmp vnet[:vnet_id] }
  #     its('name') { should cmp vnet[:vnet_name] }
  #     its('location') { should cmp vnet[:vnet_location] }
  #     its('type') { should cmp 'Microsoft.Network/virtualNetworks' }
  #     its('address_space') { should cmp vnet[:vnet_address_space] }
  #     its('tags') { should include(Workspace: terraform_workspace) }
  #   end
  #   describe azure_subnets(resource_group: resource_group['name'], vnet: vnet[:vnet_name]) do
  #     its('count') { should cmp vnet[:vnet_subnets].length }
  #     vnet[:vnet_subnets].each do |subnet|
  #       its('ids') { should include subnet }
  #     end
  #   end
  #   describe azure_virtual_network(resource_group: 'fake', name: vnet[:vnet_name]) do
  #     it { should_not exist }
  #   end
  # end
  # describe azure_virtual_network(resource_group: resource_group['name'], name: 'fake') do
  #   it { should_not exist }
  # end
end
