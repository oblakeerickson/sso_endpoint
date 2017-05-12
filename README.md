# Discourse Example SSO Endpoint

This a very simple sso endpoint to use for development and to learn how
Discourse Single-Sign-On works. Please refer to the [Official Single-Sign-On
Docs](https://meta.discourse.org/t/official-single-sign-on-for-discourse/13045?u=oblakeerickson)
for more info.

If you would like to get this SSO Endpoint running locally follow these steps:

1. Get [Discourse running
   locally](https://github.com/discourse/discourse/blob/master/docs/DEVELOPER-ADVANCED.md) in development mode
1. Clone this repo
1. `cd sso_endpoint`
1. `bundle install`
1. Start the server with this command: `rackup --host 0.0.0.0`
1. [Setup SSO](http://localhost:3000/admin/site_settings/category/all_results?filter=sso) on your Discourse instance
1. `enable_sso = true`
1. `sso_url = http://localhost:9292/sso`
1. `sso_secret = abcdefghij`
1. Browse to http://localhost:3000 and then login. You will be redirect to the
   SSO Endpoint and a random new user will be returned and created inside of
discourse with an external_id.

