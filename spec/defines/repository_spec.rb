require 'spec_helper'

describe 'approx::repository' do

  shared_examples 'approx::repository examples' do

    context 'it compiles with dependencies' do
      it { is_expected.to compile.with_all_deps }
    end

    context 'it includes ::approx' do
      it {is_expected.to contain_class('approx')}
    end

    context 'it includes concat_fragment' do
      it { is_expected.to contain_concat_fragment(title)
	.with_target('/etc/approx/approx.conf')
      }
    end

  end

  context 'whith defaults' do
    let (:title) { 'debian' }

    let :params do
      { :url          => 'https://www.cirrax.com/' }
    end

    it_behaves_like 'approx::repository examples'

  end

  context 'whith non defaults' do
    let (:title) { 'my-repo' }

    let :params do
      { :url          => 'https://www.cirrax.com/',
        :reponame     => 'debian',
	:order        => '100',
      }
    end
    it_behaves_like 'approx::repository examples'

  end
end
