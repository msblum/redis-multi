# encoding: UTF-8

require_relative 'spec_helper'

describe 'redis-multi' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it 'includes the redisio cookbook' do
    expect(chef_run).to include_recipe('redisio')
  end
end
