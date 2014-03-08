#GistBoard

This web app provides an overview of a user’s GitHub gists and details. In a simple table, information is shown that details: gist name, link to gist, comment count, date of last comment, etc. For v1, our intention is to not utilize an explicit DB, but to store information in the browser session.


##User Stories
1. As a user, I want to be able to see the most recent comment on any of my gists (date)
2. As a user, I want to be able to see all of my gists in one place
3. As a user, I want to be able to see counts of: files, comments, stars, forks
4. As a user, I want to be able to click on the title/link of the gist and be taken to it
5. As a user, I want to be able to click on a gist title and expand it so that the gist content is displayed in an iframe type embedded element*
6. As a user, I want to be able to sort all my gists by certain table headings (i.e. title, date last modified, comments, stars, forks, files)


##Next Steps
* Model
	* Add comment count and gist count methods to GistContainer
* View
	* Update variables with "real" names when routes are done
	* Fix bottom border on last row of table
	* Update formatting for long file names
	* Add media queries and other responsive features
	* Style non-auth splash screen for redirect
* Controller
	* Create session and is_auth helpers
	* Create redirect for non_auth
	* Update auth route
	* Add callback route
	* Add ruby client API calls and interact with ruby models


##Authors
* James Hulley | [jhulley](https://github.com/jhulley)
* Phil Wittig | [pdwittig](https://github.com/pdwittig)
* Alex Zeigler | [AyyZee](https://github.com/Ayyzee)
