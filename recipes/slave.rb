#
# Cookbook Name:: redis-multi
# Recipe:: redis_slave
#
# Copyright 2014, Rackspace, US Inc.
#
# All rights reserved - Do Not Redistribute
#

# include in any recipe meant to be called externally
include_recipe 'redis-multi::_base'

# find master so we can configure slaves
include_recipe 'redis-multi::_find_master'
master_ip = node['redis-multi']['redis_master']

# configure master w/ slaveof, based on found master
bind_port = node['redis-multi']['bind_port']

# if downstream doesn't supply, do a nice default
Chef::Log.warn('Checking if Redisio servers nil')
if node.deep_fetch('redisio', 'servers').nil?
  Chef::Log.warn('Redisio servers nil')
  master_data = { 'name' => "#{bind_port}-slave",
                  'port' => bind_port,
                  'slaveof' => { 'address' => master_ip,
                                 'port' => bind_port
                               }
                }
  Chef::Log.warn("Master data: #{master_data}")
  node.set['redisio']['servers'] = []
  node.set['redisio']['servers'] << master_data
else
  Chef::Log.warn("Redisio servers are #{node.deep_fetch('redisio', 'servers')}")
end

tag('redis_slave')
tag('redis')
