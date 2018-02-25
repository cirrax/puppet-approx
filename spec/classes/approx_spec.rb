
require 'spec_helper'

describe 'approx' do
  let :default_params do
     { :conffile         => '/etc/approx/approx.conf',
       :cache            => '/var/cache/approx',
       :ensure_cache     => true,
       :interval         => 60,
       :max_rate         => 'unlimited',
       :max_redirects    => 5,
       :user             => 'approx',
       :group            => 'approx',
       :syslog           => 'daemon',
       :pdiffs           => true,
       :offline          => false,
       :max_wait         => 10,
       :verbose          => false,
       :debug            => false,
       :config           => {},
       :create_resources => {},
     }
  end

  shared_examples 'approx shared examples' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_package( 'approx')
      .with_ensure('installed')
    }
    it { is_expected.to contain_concat( params[:conffile] )
      .with_owner( 'root' )
      .with_group( 'root' )
      .with_mode( '0644' )
      .with_require( 'Package[approx]')
    }

    it { is_expected.to contain_concat__fragment( 'approx.conf_header' )
      .with_target( params[:conffile] )
      .with_order('00')
    }

    it { is_expected.to contain_file( params[:cache] )
      .with_ensure( 'directory')
      .with_owner( params[:user] )
      .with_group( params[:group] )
      .with_mode( '0755' )
    }
  end

  context 'with defaults' do
    let :params do
      default_params
    end
    it_behaves_like 'approx shared examples'
  end

  context 'with ensure_cache false' do
    let :params do
      default_params.merge(
	:ensure_cache => false,
      )
    end
    it { is_expected.not_to contain_file( params[:cache] )
    }
  end

  context 'with creation of repositories' do
    let :params do
      default_params.merge(
        :config => { 'debian' => { 'url' => 'http://ftp.ch.debian.org/debian'}},
      )
    end

    it_behaves_like 'approx shared examples'
    it { is_expected.to contain_approx__repository( 'debian' )
      .with_url('http://ftp.ch.debian.org/debian')
    }
  end

  context 'with creation of resources' do
    let :params do
      default_params.merge(
        :create_resources => { 'approx::repository' => { 'debian' => { 'url' => 'http://ftp.ch.debian.org/debian'}}},
      )
    end

    it_behaves_like 'approx shared examples'
    it { is_expected.to contain_approx__repository( 'debian' )
      .with_url('http://ftp.ch.debian.org/debian')
    }
  end
end
