In this example I am using packer to create AMI and then this AMI is used in terraform file to create 1 master and 2 slave nodes.
Once the nodes are created ansible will install docker in slave noed.