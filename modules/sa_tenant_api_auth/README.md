# Module Service Account Tenant API Auth

To authenticate with the Worklytics Tenant API, you need a Google Identity Token (ID Token) that
Worklytics can verify to identify the user calling any of the Tenant API endpoints. As the
[Tenant API documentation] details, the recommended way to obtain the ID Token, is using a Service
Account (SA). Using this module, you can create that SA with the required roles.

See the [examples/create_psoxy_connections](../../examples/create_psoxy_connections) for a complete
usage example.

[Tenant API documentation]: https://docs.worklytics.co/knowledge-base/tenant-api#authentication



