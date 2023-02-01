# Kestra Validate Action

Official GitHub Action to create CI/CD pipelines that validate [Flows](https://kestra.io/docs/concepts/flows.html)
or [Templates](https://kestra.io/docs/developer-guide/templates/) before deploying to your Kestra server.

This action could be used within a workflow that runs when a `Pull Request` is triggered.

The Action version is based on the Kestra Version. Only Kestra v0.6.1+ is supported.

## What does the action do ?

* Take a folder in input containing your `Flow` **or** `Template` as yaml files. The action look recursively meaning
resources in subfolder will be validated too.
* For each resource, 2 outputs are possible:
  * `:heavy_check_mark: flow-id` when your resource is validated.
  * `:x: filename` when an error was found in your resource. Following by the error message.

## Usage

The validation can be done locally within the client, but if you have custom plugin or want your `Flows` to be validated
with TaskDefaults included, it may be more interesting to validate your resources on the server-side.

### Inputs

| Inputs        | Required           | Default | Description                                                                |
|---------------|--------------------|---------|----------------------------------------------------------------------------|
| ``directory`` | :heavy_check_mark: |         | Folder containing your resources                                           |
| ``resource``  | :x:                | flow    | Resource you want to update in your namespace, can be `flow` or `template` |
| ``server``    | :x:                |         | URL of your Kestra server, if none is provided, validation is done locally |
| ``user``      | :x:                |         | User for the basic auth                                                    |
| ``password``  | :x:                |         | Password for the basic auth                                                |

### Auth

Depending on your Kestra edition, you may need to include `user` and `password` to authenticate
on the server.

### Example

Example with `Flows`, validated on the `server-side`.

```yaml
      - name: flow update namespace action
        uses: actions/kestra-validate-action@v0.6.1
        with:
          directory: ./kestra/flows
          server: https:/kestra.io
```

Example with `Templates`, validated locally within the `Kestra Client`.

```yaml
      - name: template update namespace action
        uses: actions/kestra-validate-action@v0.6.1
        with:
          resource: template
          directory: ./kestra/templates
```