business_divsion = "tech"
environment = "dev"
resource_group_name = "rg"
resource_group_location = "eastus"
vnet_name = "vnet"
vnet_address_space = ["10.1.0.0/16"]

aks_subnet_name = "aks-subnet"
aks_subnet_address = ["10.1.1.0/24"]

private_subnet_name = "private-subnet"
private_subnet_address = ["10.1.11.0/24"]

db_subnet_name = "db-subnet"
db_subnet_address = ["10.1.21.0/24"]

bastion_subnet_name = "bastion-subnet"
bastion_subnet_address = ["10.1.100.0/24"]

aks_cluster_name = "aks"
aks_azuread_admin_group = "AKS-ADMIN-GROUP"
aks_cluster_version = "1.26.3"
aks_network_plugin = "kubenet" # Can also be "azure"
# aks_network_policy = "calico" # "azure" or "calico"
aks_enable_azure_policy = false
aks_node_os_disk_size = 30 # Can't be less than 30GBs
aks_min_node_count = 2
aks_max_node_count = 2
aks_desired_node_count = 2
aks_enable_auto_scaling = false
aks_SLA_sku_tier = "Free"   # Can also be "Paid"
aks_agents_max_pods = 100
aks_node_pool_name = "aksnodepool"
aks_agents_type = "VirtualMachineScaleSets"
aks_agents_size = "Standard_D2s_v3"
aks_admin_spn   = "k8s-admin"


# Azure SQL
db_server_name_prefix = "blog"
postgre_sku_name="GP_Gen5_4"
db_size=640000
postgres_version="11"
database_name="guest"