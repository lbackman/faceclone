# Faceclone

This is the [Final Assignment](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project) in The Odin Project’s Ruby on Rails Curriculum.
The objective of the project is to build a "clone" of Facebook.

All the core features of Facebook will be implemented; with the finished app a user should be able to:
- Send friend requests
- Accept friend requests from other users
- Publish posts on their page
- Upload a profile picture
- Post on other users' pages
- Comment on posts
- Like posts and comments

The index of the app will be the Timeline, which displays all posts that are visible to you.

This project was previously in [another repo](https://github.com/lbackman/facebook-clone), but was started from scratch because of incompatbilites with action cable and esbuild.
Many hours were spent trying to find out why it wasn't possible to connect to action cable stream.
In the end it turned out that starting a new project and copying over the models and migrations made everything work.
