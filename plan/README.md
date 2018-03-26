# Documentation

## Structure Overview

Instructions or a user "Guide" is the most fundamental documentation.

**Guide** will be minimal, as convenient, or deferred, until the product has stabilized.

**Plan** a narrative representation vs the actual implementation (code base), and the current documentation focus.

Usually when we say plan, we making a comparison of the static design goals to their (dynamic but) complementary implementation (code development),

Within the Plan, a distinction is made between the user experience (design or UX), and a technical detail (specification).

The detailed, technical specification plan, supports the UX design plan by articulating the orchestration of specific methods and API (a narrative), which creates the UX.

Since the user interface (UI) is normally matured asynchronously with the technical detail, that is also distinguished.

Here is the hierarchy:
* plan/guide/
* plan/ui/
* plan/ux/
* plan/{details}

The plan should direct the code but in the course of development,
it is natural for the code to advance ahead of documentation 
leading to a code base without a complementary specification. 

When the code deviates from the specification, it becomes difficult to identify
which takes precedence or what the trajectory is. The plan is however, more forgiving
with regard to overview and implemention details.  For this reason, the documentation should be updated
to remain the reference implementation, even if not comprehensive.



Session Management ( https://lychee.ncodamusic.org/workflow-session.html )

* Is this documentation for server functions or the client toolkit?

` class lychee.workflow.session.InteractiveSession(*args, **kwargs)[source]`

"Version control is disabled by default, and must be enabled with the vcs parameter."

* If it must be set, why not set a default?
* How is the parameter set?
* What are viable settings?

Do note that most documentation referring to the Lychee "repository" refers to the directory in which the music document is stored, whether or not the directory is a VCS repository.

* Sounds like this could be user defined (in $HOME) or system managed (/var/tmp/active-session), what are the possibilities?

`    document`

        Get a Document for this session's repository.

* Is Document a file path or stdout?

"If no repository directory has been set, this method creates a new repository in a temporary directory."

Based on what parameters, how are they known?




` read_user_settings()[source]`

    Read from this repo's user settings XML file.

* What is the facility to import, modify and export a "user settings XML file" shall we call this "preferences.xml"



` run_inbound(dtype, doc, sect_id=None)[source]`

    Run the inbound (conversion and views), document, and (if enabled) VCS workflow steps.

* Does this mean import files from client to server for use in a new managed session?


` run_outbound(views_info=None, revision=None)[source]`

    Run the outbound workflow steps (views and conversion).

* Does this mean, download session files from a managed server session to a user defined output directory?
* How are the request parameters known for the request? What files are we talking about?
* Since there are multiple files, should we have an option to zip up a directory and save a single file?
* If a multi-file output option is selected, how is a pre-existing target directory dealt with? How are pre-existing files dealt with?







## Style

I prefer not to use a static .gitignore file in the root directory, since it's generated automatically by the playbook.
https://chat.ncodamusic.org/everyone/pl/89t73fyiwbf3zye3a5chsjctca

Don't use symlinks.

The file matrix.md (in any directory) should contain an index of directory content.
(a one line description of files/folders, with relative links to ./plan/ documentation)

The file schema.md (in any directory) is for ad-hoc notes and links about development plans and intended methods.

