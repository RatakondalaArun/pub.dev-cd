# Pub.dev-CD

This [Github Action](https://github.com/marketplace/actions/pub-dev-cd) publishing dart package to [pub.dev](https://pub.dev)

## Usage

This actions depends on **dart SDK** so you must use [`uses: dart-lang/setup-dart`](https://github.com/marketplace/actions/setup-dart-sdk)

### Inputs

This action takes the following inputs:

- `creditionals`: Uses this account creditionals to publish
  You must be logged in to pub.dev to find this `creditional.json` file under

  | Platform  | path                                                                                  |
  | --------- | ------------------------------------------------------------------------------------- |
  | `Windows` | `%LOCALAPPDATA%\Pub\Cache\credentials.json` or `%APPDATA%\Pub\Cache\credentials.json` |
  | `Linux`   | `~/.pub-cache/credentials.json`                                                       |
  | `Mac-OS`  | `~/.pub-cache/credentials.json`                                                       |

  copy the contents of this file and use [GitHub secret](https://docs.github.com/en/actions/reference/encrypted-secrets) to access it in you work flow.
  *If this file doesn't exist try `dart pub logout && dart pub login`.*

- `package_path`: path to the package from root of a repository

  - defaults to root directory `.`
  - should not start with a `/` and end with `/`

## Basic Example

```yaml
name: cd-action-test-publish
on:
  release:
    types: [published] 

jobs:
  tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2.3.4

      - name: 🔧 Setup Dart SDK
        uses: dart-lang/setup-dart@v1.0
      - name: 🧪 Run tests
        run: dart test

  publish-to-pub:
    runs-on: ubuntu-latest
    needs: [tests] # only runs after the job successfully finishes
    steps:
      - uses: actions/checkout@v2.3.4

      - name: 🔧 Setup Dart SDK
        uses: dart-lang/setup-dart@v1.0 # setups dart sdk on this machine
      - name: 🚀Publish
        uses: RatakondalaArun/pub.dev-cd@v1
        with:
          creditionals: ${{secrets.PUB_CREDITIONALS}}
          # package_path: packages/subpackage
```
