<!-- BEGIN_TF_DOCS -->
# jenkins-terraform
##### PoC para ejecución de Terraform en Jenkins  
>Grupo 1  
>Diplomado DevOps - USACH

## Integrantes
- Luis Anguita
- Jesús Donoso
- Mario Friz
- Fernando Gutiérrez
- Oscar Mollo
- Carlos Tognarell

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.client_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.client_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_subnet"></a> [aks\_subnet](#input\_aks\_subnet) | Configuración básica para la subnet usada por AKS | <pre>object({<br>        name                = string<br>        address_prefixes    = list(string)<br>    })</pre> | n/a | yes |
| <a name="input_aks_vnet"></a> [aks\_vnet](#input\_aks\_vnet) | Configuración básica para la vnet usada por AKS | <pre>object({<br>        name            = string<br>        address_space   = list(string)<br>    })</pre> | n/a | yes |
| <a name="input_client_id_secret_name"></a> [client\_id\_secret\_name](#input\_client\_id\_secret\_name) | Nombre del secreto que almacena el client\_id del SP | `string` | n/a | yes |
| <a name="input_client_secret_secret_name"></a> [client\_secret\_secret\_name](#input\_client\_secret\_secret\_name) | Nombre del secreto que almacena el client\_secret del SP | `string` | n/a | yes |
| <a name="input_container_registry"></a> [container\_registry](#input\_container\_registry) | Configuración básica de ACR | <pre>object({<br>        name            = string<br>        sku             = string<br>        admin_enabled   = bool<br>    })</pre> | n/a | yes |
| <a name="input_kubernetes_cluster"></a> [kubernetes\_cluster](#input\_kubernetes\_cluster) | Información básica sobre el cluster de AKS | <pre>object({<br>        name            = string<br>        dns_prefix      = string<br>        network_plugin  = string<br>        network_policy  = string<br>        default_node_pool = object({<br>            name                = string<br>            node_count          = number<br>            vm_size             = string<br>            enable_auto_scaling = bool<br>            max_count           = number<br>            min_count           = number<br>        })<br>    })</pre> | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | La región donde se desplegarán los recursos | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | El nombre del grupo de recursos donde se generará el cluster | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_fqdn"></a> [aks\_fqdn](#output\_aks\_fqdn) | FQDN del cluster de AKS |
| <a name="output_aks_id"></a> [aks\_id](#output\_aks\_id) | Id del cluster de AKS |
| <a name="output_aks_portal_fqdn"></a> [aks\_portal\_fqdn](#output\_aks\_portal\_fqdn) | FQDN del Portal del cluster de AKS |

---
*Documentación generada con [terraform-docs](https://github.com/terraform-docs/terraform-docs)*
<!-- END_TF_DOCS -->