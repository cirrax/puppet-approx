# frozen_string_literal: true

require 'spec_helper'

describe 'approx::systemd_socket' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_systemd__dropin_file('approx.conf').with_ensure('absent') }

      it {
        is_expected.to contain_service('approx.socket')
          .with_ensure('running')
          .with_enable(true)
      }
    end
  end
end
