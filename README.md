# Validate Action

Official GitHub Action to create CI/CD pipelines that validate [Flows](https://kestra.io/docs/workflow-components/flow) before deploying to your Kestra server.

This action could be used within a workflow that runs when a `Pull Request` is triggered.

The Action version is based on the Kestra Version. Only Kestra v0.6.1+ is supported.

## What does the action do ?

* Take a folder in input containing your `Flow` **or** `Template` as yaml files. The action look recursively meaning
  resources in subfolder will be validated too.
* For each resource, 2 outputs are possible:
    * '✔️ flow-id' when your resource is validated.
    * '❌ filename' when an error was found in your resource. Following by the error message.

## Usage

### Inputs

| Inputs        | Required           | Default | Description                                                                |
|---------------|--------------------|---------|----------------------------------------------------------------------------|
| ``directory`` | :heavy_check_mark: |         | Folder containing your resources                                           |
| ``resource``  | :heavy_check_mark: |         | Resource you want to update in your namespace, can be `flow` or `template` |
| ``server``    | :x:                |         | URL of your Kestra server, if none is provided, validation is done locally |
| ``user``      | :x:                |         | User for the basic auth                                                    |
| ``password``  | :x:                |         | Password for the basic auth                                                |
| ``apiToken``  | :x:                |         | API token for EE auth                                                      |
| ``tenant``    | :x:                |         | Tenant identifier (EE only, when multi-tenancy is enabled)                 |

### Server-side validation

The validation can be done locally with the client, but if you have custom plugin or want your `Flows` to be validated
with TaskDefaults included, it may be more interesting to validate your resources on the server-side.

#### Differences between server-side and client-side validation

| Validation         | Server-side        | Client-side        | 
|--------------------|--------------------|--------------------|
| Format             | :heavy_check_mark: | :heavy_check_mark: |
| Plugins properties | :heavy_check_mark: | :x:                |
| Customs plugin     | :heavy_check_mark: | :x:                |
| Flows TaskDefaults | :heavy_check_mark: | :x:                |

### Auth

Depending on your Kestra edition, you may need to include `user` and `password` to authenticate
on the server.

### Example

Example with `Flows`, validated on the `server-side`.

```yaml
      - name: flow update namespace action
        uses: kestra-io/validate-action@master
        with:
          resource: flow
          directory: ./kestra/flows
          server: https:/kestra.io
```

Example with `Templates`, validated locally with the `Kestra Client`.

```yaml
      - name: template update namespace action
        uses: kestra-io/validate-action@master
        with:
          resource: template
          directory: ./kestra/templates
```

Read more in the documentation [here](https://kestra.io/docs/version-control-cicd/cicd/github-action).
