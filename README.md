## Overview
When running HashiCorp's Vault in K8s it is ideal to use HA mode. When you are running HA mode it would also be a good idea to use liveliness probes to remove locked vault pods from the load balancers. Besides using kubectl exec commands it would be nice to connect to the different vault nodes to unseal them. This image will aid in this endeavor to unlock the vault by using Nginx to create a service endpoint in K8s that was not closed with liveliness probes.

