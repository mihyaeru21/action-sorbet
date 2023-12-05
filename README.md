# GitHub Action: Run sorbet with reviewdog 🐶

This action runs [sorbet](https://github.com/sorbet/sorbet) with
[reviewdog](https://github.com/reviewdog/reviewdog) on pull requests to improve
code review experience.

## Inputs

### `github_token`

`GITHUB_TOKEN`. Default is `${{ github.token }}`.

### `level`

Optional. Report level for reviewdog [`info`, `warning`, `error`].
The default is `error`.

### `reporter`

Optional. Reporter of reviewdog command [`github-pr-check`, `github-check`, `github-pr-review`].
The default is `github-pr-check`.

### `filter_mode`

Optional. Filtering mode for the reviewdog command [`added`, `diff_context`, `file`, `nofilter`].
Default is `added`.

## Example usage

```yaml
name: reviewdog
on: [pull_request]
permissions:
  contents: read
  pull-requests: write
jobs:
  sorbet:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.2.0
      - uses: mihyaeru21/action-sorbet@v1
```

## License

[MIT](https://choosealicense.com/licenses/mit)
