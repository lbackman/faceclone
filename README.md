# Odin Social Media App

This is the [Final Assignment](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project) in The Odin Project’s Ruby on Rails Curriculum.
The objective of the project is to build a "clone" of Facebook.

All the core features of Facebook will be implemented; with the finished app a user should be able to:
- Send friend requests
- Accept friend requests from other users
- Publish posts on their page
- Upload a profile picture
- Comment on posts
- Like posts and comments

The index of the app will be the Timeline, which displays all posts that are visible to you.

This project was previously in [another repo](https://github.com/lbackman/facebook-clone), but was started from scratch because of incompatbilites with action cable and esbuild.
Many hours were spent trying to find out why it wasn't possible to connect to action cable stream.
In the end it turned out that starting a new project and copying over the models and migrations made everything work.

## Thoughts upon project completion

Well, this took a lot longer than anticipated.

And I realized just how much complexity is involved in building a more fleshed out app.
So I can only imagine how demanding it is to build and maintain something as big as the real Facebook.

The things that required the most time and troubleshooting were in no particular order:
- Turbo frames / streams
    * Comments are updated in real time
    * Likes and friend request actions are turbo frames
- Active Storage
    * Amazon S3 is used to store images
    * I opted to only let users upload avatars
- Omniauth / OAuth
    * Facebook no longer allows independent developers to use the OAuth API, so sadly I had to remove it

After all is said and done, I am quite happy with the project. It's not prefect, I'd say, but good enough.

Some of the things that could be added / improved:
- Make greater use of turbo streams to make the app feel more like an SPA
- Remove manual page navigation and replace it with infinite scrolling
- Allow posts to be rich text and include uploaded images
- Allow users to either make posts and upload pictures to the "Timeline"
- Implement Omniauth from other providers
- Nested comments
- Not showing all comments to a post/photo at once, and instead including a "load more comments" button
