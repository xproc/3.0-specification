# XProc 3.0: An XML Pipeline Language

This is the home of the XProc 3.0 specification developed by the
[XProc next community group](https://www.w3.org/community/xproc-next/).

Drafts are published automatically at [spec.xproc.org](http://spec.xproc.org/).

## GitHub

The XProc community is using GitHub to manage the development of this
specification. Please pull the repository, make improvements, and
propose changes in the form of pull requests.

### Continuous integration

The XProc specification is built automatically with Travis CI.

To build and publish the spec on your gh-pages, create the following
secure environment variables for your repo in the Travis CI Settings
page for your fork:

* GH_TOKEN="your git token"
* GIT_EMAIL="you@example.com"
* GIT_NAME="Your Name"
* GIT_PUB_REPO="you/3.0-specification"
* GIT_PUB_BRANCH="master"

You also have to setup a `gh-pages` branch, naturally.

## How it works

The documents are built by a gradle task that runs XML Calabash and
other tools. The individual specifications are in sub-projects.
At the time of this writing, there are seven specifications (there may
be more by the time you read this):

* `overview` is the overview page that points to all the specs
* `xproc` is _XProc 3.0: A Pipeline Language_
* `steps-intro` is introductory information about all steps
* `steps` is _XProc 3.0: Standard Step Library_
* `step-validate-relax-ng` is the `p:validate-with-relax-ng` step
* `step-validate-schematron` is the `p:validate-with-schematron` step
* `step-validate-xml-schema` is the `p:validate-with-xml-schema` step

The default gradle target, `allspecs`, will build all of the specifications.
The built specifications are in the `build/dist/` directory or directories
below it.

Within each subproject, the “source” for each specification is in
`src/main/xml/specification.xml`. There may be other files as well.
Use XInclude to break specs into pieces if you wish.

## About the workflow

It’s all a bit complicated. These are some notes.

* All specifications have a glossary; if the glossary turns out to be
  empty, because there are no term definitions (`firstterm` elements)
  in a specification, it will be elided automatically.

```xml
<xi:include href="../../../build/glossary.xml">
  <xi:fallback>
    <glossary xml:id="glossary">
      <title>Glossary</title>
      <para>Glossary needs to be generated</para>
    </glossary>
  </xi:fallback>
</xi:include>
```

* Similarly, for steps, there is a step errors appendix. It will be
  populated automatically and elided if there are no step errors.

```xml
<appendix xml:id="app.step-errors">
<title>Step Errors</title>
<para>The following <glossterm baseform="dynamic-error">dynamic errors</glossterm>
can be raised by the <code>p:validate-with-relax-ng</code> step:</para>
<?step-error-list?>
</appendix>
```

* There is a single, master bibliography in `src/main/xml/bibliography.xml`.
  In each specification, use `biblioref` to refer to bibliography entries.
  Create a `bibliolist` with empty `bibliomisc` elements to pull in the
  relevant entries from the master bibliography:

```xml
<appendix xml:id="references">
<title>References</title>
<bibliolist>
<bibliomixed xml:id="xproc30"/>
<bibliomixed xml:id="xproc30-steps"/>
<bibliomixed xml:id="iso19757-2"/>
<bibliomixed xml:id="relaxng-compact-syntax"/>
<bibliomixed xml:id="relaxng-dtd-compat"/>
</bibliolist>
</appendix>
```

* Examples and graphics are also a little complicated. I’ll describe them here
  if anyone asks. :-)

The build process is owned by [norm](mailto:ndw@nwalsh.com);
bug him if you have difficulties.

## Caveats

See [issue 229](https://github.com/relaxng/jing-trang/issues/229). I’ve installed
a locally patched version of Jing that accepts `xs:anyAtomicType`. That might get
rejected by the RELAX NG folks, or it might get replaced by something better.
It’s worth keeping an eye on.
