# Documentation

Our user Guide breaks out the primary functions of the nCoda application suite,
including components of the user interface, features and how to use them.
The Guide describes what you can do with the application.
It is the most fundamental documentation, doubling as a design requirement
during the development stage.

Accept to define the development goals, the guide will be a minimal generalization,
more of a placeholder for user documentation, until the product and user interface have stabilized.

A design Plan, or blueprint of the nCoda internal workings, is a narrative with illustrations,
representing detailed goals, specific algorithms, procedures and functions, within the code base.
(And, the current 2018Q2 documentation focus.)

All details in the Plan should be traceable to a specific objectives in the Guide.
When we refer to the Plan, we are actually making a comparison between the Guide and the Code.
To achieve the next step, we decide whether to update the plan or the code.
By measuring the quality of the code with respect to the user Guide, specific
development goals and achievements are in context, measureable and clear from multiple perspectives.

Illustration:
```
Guide / Goals  ->  Plan     ->  Code
a, b, c        ->  1, 2, 3  ->  x, y, z
```

This traceability enables better change analysis and decisions. For example, it can 
1. Illustrate the impact of switching from single application, to client/server architecture.
1. Identify level of effort related to specific deign goals.
1. Identify the blast radius of a specific bug or procedure change and identify impacted components.
1. Enable housekeeping, such as identifying and purging orphan variables and procedures no longer in use.
1. Enable timely updates and enhancements by indexing procedures and variables according to context and purpose.

When we trace goals through to the plan and on to the code,
an opportunity exists to align all aspects of development management,
notably, the trajectory of efforts and a basis for quality checks, for ongoing stability.
Efforts are wasted when goals are too vague for quality checks, or the day after an objective is met, everybody moves in opposite directions.

Within the Plan, a distinction is made between the user experience (UX design) and a technical details (specification).
The detailed specification supports the UX by narrating the orchestration of methods and API to create the UX.

Since the user interface (UI) is normally matured asynchronously with the technical detail, that is also distinguished.

Here is the hierarchy of the documentation and plans:
* `./plan/guide/` - user guide
* `./plan/ui/` - user interface
* `./plan/ux/` - user experience
* `./plan/` - detail index

Graphviz Illustration: `Guide -> UX -> detail -> code -> UI` 


The plan detail should direct the code but in the course of development,
it is natural for the code to advance ahead of documentation,
leading to a code base without complementary specification
ties to the requirements (user guide)

When code deviates from a specification, best trajectories and precedence of efforts 
are difficult to identify. The interpretation of the plan is however, more forgiving than the code.
For this reason, the documentation should be updated to remain the reference plan, at all times vs code
(even if the reference plan is not comprehensive into the details).

# Questions about the current codebase

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



# Queue for additional questions

( https://chat.ncodamusic.org/everyone/pl/ih63oga6m7nw7rpmdxww5y9fmw )
* https://lychee.ncodamusic.org/basic_concepts.html#generic-workflow
* https://lychee.ncodamusic.org/workflow-steps.html#lychee.workflow.steps.do_inbound_conversion
* https://lychee.ncodamusic.org/workflow-session.html
* it may not exist, but lychee.workflow.* is as high-level as you can get in Lychee. The functions in lychee.workflow.steps correspond exactly with those described in the "Generic Workflow," and the InteractiveSession object is what calls those functions
* http://www.tornadoweb.org/en/stable/
* https://spivak.ncodamusic.org/t/windows-installation-instructions/735


## Style

I prefer not to use a static .gitignore file in the root directory, since it's generated automatically by the playbook.
https://chat.ncodamusic.org/everyone/pl/89t73fyiwbf3zye3a5chsjctca

Don't use symlinks.

The file matrix.md (in any directory) should contain an index of directory content.
(a one line description of files/folders, with relative links to ./plan/ documentation)

The file schema.md (in any directory) is for ad-hoc notes and links about development plans and intended methods.

