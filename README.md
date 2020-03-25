List Merged Pull Requests
===

This action lists merged requests on the source branch when a PR is created.  

## Supported actions
- event: `pull_request`
- action: `opened`

## Inputs

### `token`

**Required** The GitHub Access Token.

## Outputs

None

### Sample workflow

```
name: list-merged-pull-requests example
on:
  pull_request:
    types: [opened]
    branches: [master]
jobs:
  example:
    name: release management comment
    runs-on: ubuntu-latest
    steps:
      - name: comment PR
        uses: tiwanari/list-merged-pull-requests@master
```
