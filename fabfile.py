
#!/usr/bin/env python
from fabric.api import local
import boto.ec2
import boto, urllib2
from   boto.ec2 import connect_to_region
from   fabric.api import env, run, cd, settings, sudo, put
from   fabric.api import parallel
import os
import sys
import time


# def uptime():
#   local('uptime')
#   print 'tasks done, now sleeping for 10 seconds'
#   for i in xrange(30,0,-1):
#     print 'Starting the instance.. wait please.. watch me out :P carefully'
#     time.sleep(1)
#     print i
  
# def pull_from_git():
#   print 'cloning from git'
#   local('git clone https://*******/****/***/mediabenchmark.git')
#   local('sudo cp mediabenchmark/*.sh ~/')
#   print 'Cloning done'

def get_ec2():
  env.user = "ubuntu"
  env.key_filename = ["~/.ssh/pem.txt"]
  public_dns = [];
  conn = boto.ec2.connect_to_region("us-west-2",aws_access_key_id='*************',aws_secret_access_key='*************')
  reservations = conn.get_all_reservations() 
  conn.run_instances('******',key_name='AWS_key',instance_type='t2.micro',security_groups=['Name'])
  local('sleep 20')
  print reservations
  for reservation in reservations:  
    for instance in reservation.instances:
      print "Instance", instance.public_dns_name
      public_dns.append(str(instance.public_dns_name))
  dns = public_dns
  env.hosts = dns
  print env.hosts
  put('nginx.sh','/home/ubuntu')
  sudo("chmod 755 nginx.sh")
  sudo("./nginx.sh")
  

   
  
  

