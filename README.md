[![License](https://img.shields.io/github/license/heinrichreimer/action-github-changelog-generator.svg?style=flat-square)](LICENSE)
[![Last commit](https://img.shields.io/github/last-commit/heinrichreimer/action-github-changelog-generator.svg?style=flat-square)](https://github.com/heinrichreimer/action-github-changelog-generator/commits)
[![Latest tag](https://img.shields.io/github/tag/heinrichreimer/action-github-changelog-generator.svg?style=flat-square)](https://github.com/heinrichreimer/action-github-changelog-generator/releases)
[![Issues](https://img.shields.io/github/issues/heinrichreimer/action-github-changelog-generator.svg?style=flat-square)](https://github.com/heinrichreimer/action-github-changelog-generator/issues)
[![Pull requests](https://img.shields.io/github/issues-pr/heinrichreimer/action-github-changelog-generator.svg?style=flat-square)](https://github.com/heinrichreimer/action-github-changelog-generator/pulls)

# ✏️ action-github-changelog-generator

Automatically generate change log from your tags, issues, labels and pull requests on GitHub,
using [github-changelog-generator](https://github.com/github-changelog-generator/github-changelog-generator)'s
[Docker image](https://github.com/github-changelog-generator/docker-github-changelog-generator).

This action also makes the changelog available to other actions as [output](#outputs).

## Example usage

```yaml
uses: heinrichreimer/github-changelog-generator-action@v2.1.1
with:
  token: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

| Name | Description | Default |
|---|---|---|
| `repo` | Target GitHub repo in the form of organization/repository. | [inherit] |
| `user` | Username of the owner of target GitHub repo. | [inherit] |
| `project` | Name of project on GitHub. | [inherit] |
| `token` | To make more than 50 requests per hour your GitHub token is required. | [inherit] |
| `dateFormat` | Date format. | [inherit] |
| `output` | Output file. | [inherit] |
| `base` | Optional base file to append generated changes to. | [inherit] |
| `headerLabel` | Set up custom header label. | [inherit] |
| `configureSections` | Define your own set of sections which overrides all default sections. | [inherit] |
| `addSections` | Add new sections but keep the default sections. | [inherit] |
| `frontMatter` | Add YAML front matter. Formatted as JSON because it's easier to add on the command line. | [inherit] |
| `issues` | Include closed issues in changelog. | [inherit] |
| `issuesWoLabels` | Include closed issues without labels in changelog. | [inherit] |
| `pullRequests` | Include pull-requests in changelog. | [inherit] |
| `prWoLabels` | Include pull requests without labels in changelog. | [inherit] |
| `filterByMilestone` | Use milestone to detect when issue was resolved. | [inherit] |
| `author` | Add author of pull request at the end. | [inherit] |
| `usernamesAsGithubLogins` | Use GitHub tags instead of Markdown links for the author of an issue or pull-request. | [inherit] |
| `unreleasedOnly` | Generate log from unreleased closed issues only. | [inherit] |
| `unreleased` | Add to log unreleased closed issues. | [inherit] |
| `unreleasedLabel` | Set up custom label for unreleased closed issues section. | [inherit] |
| `compareLink` | Include compare link (Full Changelog) between older version and newer version. | [inherit] |
| `includeLabels` | Of the labeled issues, only include the ones with the specified labels. | [inherit] |
| `excludeLabels` | Issues with the specified labels will be excluded from changelog. | [inherit] |
| `issueLineLabels` | The specified labels will be shown in brackets next to each matching issue. Use "ALL" to show all labels. | [inherit] |
| `excludeTags` | Changelog will exclude specified tags. | [inherit] |
| `excludeTagsRegex` | Apply a regular expression on tag names so that they can be excluded. | [inherit] |
| `sinceTag` | Changelog will start after specified tag. | [inherit] |
| `dueTag` | Changelog will end before specified tag. | [inherit] |
| `maxIssues` | Maximum number of issues to fetch from GitHub. | [inherit] |
| `releaseUrl` | The URL to point to for release links, in printf format (with the tag as variable). | [inherit] |
| `githubSite` | The Enterprise GitHub site where your project is hosted. | [inherit] |
| `githubApi` | The enterprise endpoint to use for your GitHub API. | [inherit] |
| `simpleList` | Create a simple list from issues and pull requests. | [inherit] |
| `futureRelease` | Put the unreleased changes in the specified release number. | [inherit] |
| `releaseBranch` | Limit pull requests to the release branch, such as master or release. | [inherit] |
| `httpCache` | Use HTTP Cache to cache GitHub API requests (useful for large repos). | [inherit] |
| `cacheFile` | Filename to use for cache. | [inherit] |
| `cacheLog` | Filename to use for cache log. | [inherit] |
| `sslCaFile` | Path to cacert.pem file. | [inherit] |
| `verbose` | Run verbosely. | [inherit] |
| `breakingLabel` | Set up custom label for breaking changes section. | [inherit] |
| `breakingLabels` | Issues with these labels will be added to a new section, called "Breaking changes". | [inherit] |
| `enhancementLabel` | Set up custom label for enhancements section. | [inherit] |
| `enhancementLabels` | Issues with the specified labels will be added to "Implemented enhancements" section. | [inherit] |
| `bugsLabel` | Set up custom label for bug-fixes section. | [inherit] |
| `bugLabels` | Issues with the specified labels will be added to "Fixed bugs" section. | [inherit] |
| `deprecatedLabel` | Set up custom label for deprecated section. | [inherit] |
| `deprecatedLabels` | Issues with the specified labels will be added to a section called "Deprecated". | [inherit] |
| `removedLabel` | Set up custom label for removed section. | [inherit] |
| `removedLabels` | Issues with the specified labels will be added to a section called "Removed". | [inherit] |
| `securityLabel` | Set up custom label for security section. | [inherit] |
| `securityLabels` | Issues with the specified labels will be added to a section called "Security fixes". | [inherit] |
| `issuesLabel` | Set up custom label for closed-issues section. | [inherit] |
| `prLabel` | Set up custom label for pull requests section. | [inherit] |
| `onlyLastTag` | Changelog will only show last tag. | `false` |
| `stripHeaders` | Strip headers and only show changes. | `false` |
| `stripGeneratorNotice` | Strip generator notice. | `false` |

Most inputs inherit their defaults from 
[github-changelog-generator][inherit].

## Outputs

| Name | Description |
|---|---|
| `changelog` | Contents of generated change log. |

[inherit]: https://github.com/github-changelog-generator/github-changelog-generator/wiki/Advanced-change-log-generation-examples#additional-options "Inherited from github-changelog-generator."
please
