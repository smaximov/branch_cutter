# BranchCutter

Delete merged remote branches after closing pull requests
(loosely based on https://github.com/serokell/junkscraper).

## Setup

Fetch dependencies and compile the app:

``` bash
$ mix do deps.get, compile
```

Generate a secret key which will be used for validating webhook payloads:

``` bash
$ mix secret
```

### GitHub

Create a new webhook for your repository or organization with the following settings:

* **Payload URL**: `https://$BASE_URL/webhook`.
* **Content type**: `application/json`.
* **Secret**: the secret key you have generated previously.
* **Which events would you like to trigger this webhook**: `Pull requests`.

Go to [Personal access tokens](https://github.com/settings/tokens) and generate a new
token with the `repo` scope.

### Environment

The application reads its configuration from the following environment variables:

* `PORT`: the port to run the server.
* `GITHUB_SECRET`: the webhook secret key.
* `GITHUB_TOKEN`: the personal access token.

## Release management

See the [Distillery docs](https://hexdocs.pm/distillery/getting-started.html).

## Deployment

### Gigalixir

This app can be deployed to [Gigalixir](https://gigalixir.com/), see the
[docs](http://gigalixir.readthedocs.io) for details.
