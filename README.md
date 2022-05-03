<!-- BEGIN_TF_DOCS -->
# jenkins-terraform
##### PoC para ejecución de Terraform en Jenkins  
>Fernando Gutiérrez A.
>Cloud Engineer

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_akv_name"></a> [akv\_name](#input\_akv\_name) | El nombre del Azure Key Vault que almacena los secretos | `string` | n/a | yes |
| <a name="input_akv_resource_group"></a> [akv\_resource\_group](#input\_akv\_resource\_group) | El nombre del resource group donde se encuentra el Azure Key Vault | `string` | n/a | yes |
| <a name="input_nsg_rules"></a> [nsg\_rules](#input\_nsg\_rules) | Listado de NSG rules a aplicar | <pre>list(<br>        object({<br>            name                       = string<br>            priority                   = number<br>            direction                  = string<br>            access                     = string<br>            protocol                   = string<br>            source_port_range          = string<br>            destination_port_range     = string<br>            source_address_prefix      = string<br>            destination_address_prefix = string<br>        })<br>    )</pre> | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | La región donde se desplegarán los recursos | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | El nombre del grupo de recursos donde se generará el cluster | `string` | n/a | yes |
| <a name="input_vm_list"></a> [vm\_list](#input\_vm\_list) | Listado de VMs a crear | <pre>map(<br>        object({<br>            vm_name = string<br>            size    = string<br>        })<br>    )</pre> | n/a | yes |
| <a name="input_vm_subnet"></a> [vm\_subnet](#input\_vm\_subnet) | Configuración básica para la subnet usada por las VMs | <pre>object({<br>        name                = string<br>        address_prefixes    = list(string)<br>        resource_group      = string<br>        vnet_name           = string<br>    })</pre> | n/a | yes |

## Outputs

No outputs.

---
*Documentación generada con [terraform-docs](https://github.com/terraform-docs/terraform-docs)*
<!-- END_TF_DOCS -->