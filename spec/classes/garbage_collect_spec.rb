
require 'spec_helper'

describe 'approx::garbage_collect' do
  it { is_expected.to compile.with_all_deps }

  it 'configures a cron' do
    is_expected.to contain_cron('approx-gc').with(
      command: '/usr/sbin/approx-gc -q',
      user: 'root',
    )
  end
end
