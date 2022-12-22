# frozen_string_literal: true

# copyright: 2022, Rearc LLC


control 'aws-virtual-network' do
  impact 'critical'
  title 'Ensure Forbidden VPC ID does not exist' # A human-readable title
  aws_regions.region_names.each do | region |
    describe aws_vpcs( aws_region: region ) do
      its('vpc_ids') { should_not include(vpc_id: 'vpc-deadbeef') }
    end
  end
end

include_controls 'inspec-aws'
