# Solace PubSub+ Software Event Broker Rest Delivery Terraform Module

Terraform module to support the setup of a [REST consumer](https://docs.solace.com/API/REST/REST-Consumers.htm) on the [Solace PubSub+ Event Broker](https://solace.com/products/event-broker/).

Given a queue, as a destination for messages to be forwarded to a REST consumer application, this module configures a [REST delivery point](https://docs.solace.com/API/REST/REST-Consumers.htm#_Toc433874658) between the queue and the application.

Specific use case details are provided in the [Examples](#examples).

## Module input variables

### Required

* `msg_vpn_name` - REST delivery points are specific to a Message VPN on the broker.
* `url` - The REST consumer destination URL including base URL and endpoint path. The path portion of the URL may contain [substitution expressions](https://docs.solace.com/Messaging/Substitution-Expressions-Overview.htm).
* `rest_delivery_point_name` - The name of the REST delivery point to be created.
* `queue_name` - The name of the queue to bind to.

Important: The REST Delivery Point must have permission to consume messages from the queue — to achieve this, the queue’s owner must be set to `#rdp/<rest_delivery_point_name>` or the queue’s permissions for non-owner clients must be set to at least `consume` level access.


### Optional

* `rest_consumer_name` - The name of the REST consumer to be created. The default is `consumer`.
* `request_headers` - A set of request headers to be added to the HTTP request
* `oauth_jwt_claims` - A set of additional claims to be added to the JWT sent to the OAuth token request endpoint

Additional optional module variables names are the same as the underlying resource attributes. The recommended approach to determine variable name mappings is to look up the resource's documentation for matching attribute names:

| Resource name |
|---------------|
|[solacebroker_msg_vpn_rest_delivery_point](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs/resources/msg_vpn_rest_delivery_point#optional)|
|[solacebroker_msg_vpn_rest_delivery_point_rest_consumer](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs/resources/msg_vpn_rest_delivery_point_rest_consumer#optional)|
|[solacebroker_msg_vpn_rest_delivery_point_queue_binding](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs/resources/msg_vpn_rest_delivery_point_queue_binding#optional)|
|[solacebroker_msg_vpn_rest_delivery_point_queue_binding_request_header](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs/resources/msg_vpn_rest_delivery_point_queue_binding_request_header#optional)|
|[solacebroker_msg_vpn_rest_delivery_point_rest_consumer_oauth_jwt_claim](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs/resources/msg_vpn_rest_delivery_point_rest_consumer_oauth_jwt_claim#optional)|

Most optional variables' default value is `null`, meaning that if not provided then the resource default value will be provisioned on the broker.

-> The module default for the `enabled` optional variables is `true`, which differ from the resource attribute defaults.

## Module outputs

[Module outputs](https://developer.hashicorp.com/terraform/language/values/outputs) provide reference to created resources. Any reference to a resource that has not been created will be set to `(null)`.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_solacebroker"></a> [solacebroker](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest) | ~> 0.9 |

## Resources

The following table shows the resources created for each `endpoint-type` value. "X" denotes a resource always created, "O" is a resource that may be created optionally  

| Name | queue | topic_endpoint | queue_template | topic_endpoint_template |
|------|------|------|------|------|
| solacebroker_msg_vpn_queue | X | | | |
| solacebroker_msg_vpn_jndi_queue | O | | | |
| solacebroker_msg_vpn_queue_subscription | O | | | |
| solacebroker_msg_vpn_topic_endpoint | | X | | |
| solacebroker_msg_vpn_jndi_topic | | O | | |
| solacebroker_msg_vpn_queue_template | | | X | |
| solacebroker_msg_vpn_topic_endpoint_template | | | | X |

## Examples

Refer to the following configuration examples:

- Queue
    - [Exclusive queue](examples/exclusive-queue)
    - [Non-exclusive queue](examples/non-exclusive-queue)
    - [Partitioned queue](examples/partitioned-queue)
    - [Queue with topic subscriptions](examples/queue-with-topic-subscriptions)
    - [Queue with exposed JNDI](examples/queue-with-jndi)
- [Queue template](examples/queue-template)
- [Topic endpoint](examples/topic-endpoint)
    - [Topic endpoint with exposed JNDI](examples/topic-endpoint-with-jndi)
- [Topic endpoint template](examples/topic-endpoint-template)

## Module use recommendations

This module is expected to be used primarily by application teams. It supports provisioning endpoints or templates required by a specific application. It may be forked and adjusted with private defaults.

## Resources

For more information about Solace technology in general please visit these resources:

- Solace [Technical Documentation](https://docs.solace.com/)
- The Solace Developer Portal website at: [solace.dev](//solace.dev/)
- Understanding [Solace technology](//solace.com/products/platform/)
- Ask the [Solace community](//dev.solace.com/community/).
