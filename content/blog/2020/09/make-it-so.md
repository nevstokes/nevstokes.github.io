---
title: "Make It So"
date: 2020-09-17T22:13:38Z
summary: "I'm a big fan of automating repetitive work with a `Makefile`, especially when multiple steps or dependency chains are involved."
tags: ["dev", "make", "work"]
---
{{< quote text="Something is wrong if workers do not look around each day, find things that are tedious or boring, and then rewrite the procedures." author="Taiichi Ohno" >}}

In recent years there's been something of a resurgence in using a `Makefile` for project orchestration. If you're not familiar, `Make` is used to define targets which will perform assigned actions. Its intended purpose is to create assets although it is also possible to treat it as a task runner along the lines of `gulp` or `grunt`.

`Make` is well-established, widely available and [largely portable](https://www.gnu.org/prep/standards/html_node/Utilities-in-Makefiles.html#Utilities-in-Makefiles). It provides an efficient, self-documenting single point of entry which negates multiple scripts littering the repository. With a bit of forethought, you can craft some semantic sugar that gives an immediate contextual hint as what each target will do in easy-to-understand natural language.

Orchestrating in this way means that as well as being runnable on a developer's local machine, there's no vendor lock-in to any CI or ties to third-party plugins. It doesn't matter if the project is using Jenkins, GitHub Actions or Travis, we can defer control to `Make`.

Another way to leverage these targets is with `git` hooks to implement some preventative and corrective actions during local development and get faster feedback loops or on the server-side of the version control system to facilitate [GitOps](https://www.gitops.tech/) deployments.

In addition to IDE-level tooling, using the fastest tools earliest in the git hook lifecycle provides useful feedback in a timely manner.

I've outlined some examples of potential targets and use-cases below:

## Client-side hooks

<details open>
    <summary><code>pre-commit</code></summary>
    <dl>
        <dt><code>make nice</code></dt>
        <dd>Quick linting and code style enforcement.</dd>
        <dt><code>make safe</code></dt>
        <dd>Scan for security anti-patterns and secrets like passwords, tokens or API keys that may have been accidentally added to the codebase.</dd>
    </dl>
</details>

<details open>
    <summary><code>commit-msg</code></summary>
    <dl>
        <dt><code>make commit</code></dt>
        <dd>Check that the commit message meets any mandated requirements.</dd>
    </dl>
</details>

<details open>
    <summary><code>pre-push</code></summary>
    <dl>
        <dt><code>make checks</code></dt>
        <dd>Run auditing or compliance tasks such as checking for accessibility issues, licence violations, and outdated or vulnerable dependencies.</dd>
    </dl>
</details>

## Server-side hooks

<details open>
    <summary><code>pre-receive</code></summary>
    <dl>
        <dt><code>make sure</code></dt>
        <dd>Developers are free to disable their local hooks. Run those same commands to double check and fail early should anything not be right.</dd>
    </dl>
</details>

<details open>
    <summary><code>post-receive</code></summary>
    <dl>
        <dt><code>make tests</code></dt>
        <dd>Run functional tests: unit, contract, mocked integration, regression, and mutation as applicable.</dd>
        <dt><code>make decision</code></dt>
        <dd>Quality gates. Get a go / no go to proceed further.</dd>
        <dt><code>make build</code></dt>
        <dd>Create an OCI container image or generate a static website archive.</dd>
        <dt><code>make infrastructure</code></dt>
        <dd>Provision resources as defined by declarative infrastructure as code.</dd>
        <dt><code>make deployment</code></dt>
        <dd>Once all the preceeding steps have been completed, the artifacts can be pushed with confidence. Run transactional end-to-end tests along with non-functional tests such as for security and performance.</dd>
        <dt><code>make release</code></dt>
        <dd>Just as an automated blue / green deployment gives an opportunity to gradually deploy and rollback if any errors are detected, a seperate progressive release strategy provides a safety net should anything go awry at the final step.</dd>
        <dt><code>make documentation</code></dt>
        <dd>Generate and publish API specifications.</dd>
        <dt><code>make comms</code></dt>
        <dd>Circulate release notes or make an announcement on a messaging platform.</dd>
    </dl>
</details>

Note that there is no direct implication of the underlying technologies used with these abstractions; it's completely language-independent and tooling-agnostic. The responsibility for implementing the work lies with the projects using this framework.

That said, quite a bit can be inferred from file-based conventions. Taking inspiration from Heroku's concept of Buildpacks which were designed to handle deployments at scale, it's possible to construct a matrix of trigger files and corresponding tools.

This defines a set of predefined tasks which can be run in parallel at each stage in the process, where any one of them could stop the pipeline should it find an issue.

<div tabindex="0" aria-role="region" aria-label="Pipeline stage tooling matrix">
    <table>
        <thead>
            <tr>
                <th></th>
                <th><code>nice</code></th>
                <th><code>safe</code></th>
                <th><code>checks</code></th>
                <th><code>tests</code></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><code>package.json</code></td>
                <td><code>prettier</code></td>
                <td><code>eslint-plugin-security</code></td>
                <td><code>resolve-audit</code></td>
                <td><code>stryker</code></td>
            </tr>
                <tr><td><code>requirements.txt</code></td>
                <td><code>flake8</code></td>
                <td><code>bandit</code></td>
                <td><code>safety</code></td>
                <td><code>mutmut</code></td>
            </tr>
            <tr>
                <td><code>Dockerfile</code></td>
                <td><code>hadolint</code></td>
                <td><code>semgrep</code></td>
                <td><code>snyk</code></td>
                <td><code>inspec</code></td>
            </tr>
            <tr>
                <td><code>cdk.json</code></td>
                <td><code>eslint</code></td>
                <td><code>cfn_nag</code></td>
                <td><code>opa</code></td>
                <td><code>jest</code></td>
            </tr>
        </tbody>
    </table>
</div>

This is just by way of some minimal examples. In reality there could be layers or combinations of tools applied at each stage. A more fine-grained control of what to do -- and when -- can be achieved by adding targets to appropriate lists based on the presence of individual configuration files, such as:

- `.eslintrc.js`
- `.prettierrc`
- `cypress.json`
- `jest.config.js`

The point is that the developers now don't have to think about a lot of this stuff; it's taken care of for them and they can focus on what they want to do -- namely writing quality code. Paving the roads and providing secure defaults for the quickest, smoothest paths to production.

Alignment on a small selection of languages gives continuity and allows planning for recruitment and maintenance. Doing this too for frameworks and libraries as well as approach and tooling -- with caveats of freedom of OS and IDE -- can guarantee consistency and adherence to best-practice.
