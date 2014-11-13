### 0.3.0 - 11/14/14

* Updated app to use Rails 4.0.11
* Updated the app's gem dependencies
* Added scripts to monitor and kill the resque pool
* Added a robots.txt file for production server
* Added a sitemap.xml file for production server
* Bug fixes
  * Fixed the restart_resque.sh script to properly kill workers
  * Fixed a bug where thumnail images were bleeding into text

### 0.2.1 - 10/24/14

* Bug fixes
  * Only show "Add to Collection" button when user is logged in.
  * The "Clear Limits" button in the facets display now returns the user to the catalog instead of the home page.
  * Removed "A PDF is preferred" from Datasets and Generic Works forms.
  * Collection display page now correctly displays the creator next to the title.
  * The "more" link when using facets now works properly

### 0.2.0 - 10/13/14

* Change home page to link to new ScholarBlog
* Add Google Analytics tracking code
* Change format of buttons on home page carousel
* Add CHANGELOG
* Bug fixes
  * Fix links to contact form on FAQ and About Us pages
  * Tweak wording on File Format Advice page
  * Fix path to jquery0zrssfeed.min.js
  * Remove unneeded holder.js
  * Fix deavtivate account button


### 0.1.0 - 9/30/14

* Initial release

### Pre-release - 9/8/14

* Updated names of all non bootstrap ids and classes to use "uc_" prefix
* Used site-subtitle id for Research Hub message and moved search bar to same line as action buttons
* Adds Hydra icon and language to footer
* Changes to title_bar and brand_bar for UC Styling and naming.
* Adds user_root route to config.rb for login redirect.
* Creates routes, actions, and views for faq, policy, and fair_use pages.
* changes plus to add new with dropdown caret
* Update recipients_list.yml
* Update mailboxer.rb
* adds new images for three feature areas and modifies _exhibits.html.erb
* adds new slideshow images and text with view button linking to Collection Policy
* adds routes, actions, and views for extended policy and terms modifications.
* Expanded slider view and images.
* Bugfix RSS Partial
* Update overall responsiveness

### Pre-release - 8/21/14

* Installed and integrated clamav anti-virus.
* Updated branding and style to reflect UC Theme / Colors/ Responsive design.
* Added Presentation splash page, About pages, and Terms and Condition Page.
* Changed root_home to go to Presentation splash page.

### Pre-release - 6/25/14

* Fixed bug where adding an editor or creator might delete an existing person in the list

### Pre-release - 5/21/14

* Remove Embargo date when object is not embargoed.
* Resets Representative value of parent object when file is deleted.
* Updates Gemspec to work for hydra-dervivatives.
* Fixes problems with turbolinks and autocomplete.
* Tweaks how future date validation works.
* Adds multi-value presence validation.
* Fixes embargo when visibility is set via default.
* Fixes predicate_mappings.yml file path for generator.
* Handles Groups Controller error.
* Adjusts Group Membership user comparison.
* Removes conflicting Solr filters for Group.
* Fixes issue with adding editors to a generic work.
* Changes Group to rely on user_key instead of depositor.

### Pre-release - 5/2/14

* Repository manaagers can now discover and edit embargoed content.
* Contributors may be added without creating them as a user. 
* Fix vertical alignment problem between required information on left and content editors on right. 
* Fix error when a work is created with a collaborative group.
* Convert browse_everything js to coffee script for work with turbo links.
* Fix error when a new user is a repository manager and signs up for new account.
* Validate that groups have at least one editor.
* Display error message when user attempts to delete all members from a group.
* Fix error when a group member is deleted and added back in one update.
* Increase the maximum display result for groups to 50.
* Fix duplicate group label display.
* A profile section should always be open/public
* Add visual enhancements to the My groups management page.
* Do not show My Content section to unauthenticated users.
* Do not list proxies as contributers.
* Display only works and collections which have open access on profile.
* Set default access rights on works and collections to open/public.

### Pre-release - 4/9/14

* Fixed a problem where entering a password that is too short when creating an account broke the creation process.
* Fixed a problem where users would sometimes get multiple delete confirmation dialogs
* Setting content as embargoed now properly hides the content until the embargo date.
* Users designated as “repository managers” can now edit other users’ profiles.
* Users designated as “repository managers” can now discover other users’ embargoed content.
* Organizations are now functional and have been renamed “Groups"
* URL links on profile pages are now clickable.
* User profile pages have been re-designed.
* Users are now returned to the parent work after editing a file.
* When creating works, users can now add content from cloud services such as Dropbox and Google Drive (this feature is not active yet).
* Proxies have been renamed “delegates."
* Licensing terms are now displayed on a work’s page.
* Users can now add editors while creating a work.

### Pre-release - 3/12/14

* URLs in Profiles are now clickable.
* Sort options are now working with search results and browse of creators, works and collections.
* When uploading a work, auto-complete now works the on contributor fields.
* End of word match on a search. ('photograph' should retrieve photograph and photographs)
* Implemented a "soft delete" option that retains objects in Fedora after they have been deleted.  (Soft delete is currently turned OFF in CurateUC).
* Collections can now be deleted by their owner.
* The collections edit page now displays all of the objects belonging to that collection.
* Works can now be deleted by their owner.
* Specific users can now be designated as a "repository manager" giving them full rights to edit and delete any works or collections.
* Users can now create "organizations."  This feature does not yet have a function and will be renamed to "groups" in a future version.
* The user interface is now customized with UC's colors and logo (temporary).