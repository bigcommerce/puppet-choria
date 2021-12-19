require "spec_helper"

describe 'choria::broker' do

  let :node do
    "rspec.puppet.com"
  end

  let :params do
    { manage_mcollective: false }
  end


  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end
      context 'with all defaults' do
        it { is_expected.to compile.with_all_deps }
      end

      context 'with a customized write_deadline' do
        let :params do
          { write_deadline: 5 }
        end
        it 'should configure the choria network write deadline' do
          is_expected.to contain_file('/etc/choria/broker.conf')
            .with_content(/^plugin.choria.network.write_deadline = 5$/)
        end
      end
    end
  end
end
