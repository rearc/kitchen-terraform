aws_region = input('output_region')
vpcs = input('output_vpcs')

title 'Default Section'
control 'aws-virtual-network' do
  impact 'critical'
  title 'Inspect Virtual Private Clouds' # A human-readable title
  vpcs.each do |_, vpc|
    describe aws_vpc( aws_region: aws_region, vpc_id: vpc[:vpc_id] ) do
      it { should exist }
      its('cidr_block') { should cmp '10.0.0.0/16' }
    end
  end
end
