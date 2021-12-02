List Merged Pull Requests
===

This action lists merged pull requests on the source branch when a pull request is created as you configure.

## Example
You can see an example [here](https://github.com/tiwanari/list-merged-pull-requests/pull/55).

![comment_from_bot](./docs/comment_from_bot.png)

## Supported actions
- event: `pull_request`
- action: `opened` and `synchronized` are recommended

## Inputs

### `token`

**Required** The GitHub Access Token.

## Outputs

None

## Sample workflow

```yml
name: list-merged-pull-requests example
on:
  pull_request:
    types: [opened, synchronize]
    branches: [main]
jobs:
  example:
    name: Release management comment
    runs-on: ubuntu-latest
    steps:
      - name: Comment on PR
        uses: tiwanari/list-merged-pull-requests@master
        with:
          token: ${{ github.token }}
```

## License
MIT
