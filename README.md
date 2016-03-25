# chef-repo

Chef Zero Recipes for AWS EC2 Linux AMI.


## recipes

 - elasticsearch
 - gobrew
 - golang
 - mongodb
 - newrelic
 - newrelic-plugin-agent
 - nginx
 - nodebrew
 - node.js
 - redis
 - stunnel
 - td-agent
 - yum


## prepare

    $ sudo yum update -y
    $ sudo yum install -y git
    $ curl -L http://www.opscode.com/chef/install.sh | sudo bash -s -- -v 12.6.0


## run

    $ git clone https://github.com/stoshiya/chef-repo.git
    $ cd chef-repo
    $ sudo chef-client -z -c client.rb -j nodes/COOKBOOK.json


## create new cookbook

    $ knife cookbook create NEW_COOKBOOK -o site-cookbooks
    $ vim site-cookbooks/NEW_COOKBOOK/recipes/default.rb
    $ vim nodes/NEW_COOKBOOK.json
    $ sudo chef-client -z -c client.rb -j nodes/NEW_COOKBOOK.json
