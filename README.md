# Heroku Bundle for [Cog](http://github.com/operable/cog)

Overview
```
heroku:app (list)
heroku:app info <app>

heroku:config [--app app]
heroku:config set <name=value> [--app app]
heroku:config unset <name> [--app app]

heroku:ps  [--app app]
heroku:ps scale <name=dynos>  [--app app]
heroku:ps restart <name>  [--app app]

heroku:release (list)  [--app app]
heroku:release rollback <release>  [--app app]

heroku:user (list) [--app app]
heroku:user add <email>  [--app app]
heroku:user remove <email>  [--app app]
```

Examples
```
@vanstee: !heroku:app (or !heroku app list)
@cog:
NAME            OWNER
flywheel-prod   mark@operable.io
flywheel-stage  mark@operable.io
slack-cog       mark@operable.io

@vanstee: !heroku:app info flywheel-prod
@cog:
Addons:        heroku-postgresql:standard-0
ssl:endpoint

Collaborators: chris@operable.io
kevin@operable.io
matt@operable.io
patrick@operable.io

Dynos:         1
Git URL:       https://git.heroku.com/flywheel-prod.git
Owner Email:   mark@operable.io
Region:        us
Repo Size:     1M
Slug Size:     101M
Stack:         cedar-14
Web URL:       https://flywheel-prod.herokuapp.com/
Workers:       0

@vanstee: !heroku:config
@cog:
SLACK_API_TOKEN: xoxob-1982oiajfwoiq2u8-q23iohfahfq0-2fhaefha4f23ou
DATABASE_URL:    postgres://admin:password@localhost:5432/flywheel_prod

@vanstee: !heroku:config --app flywheel-prod set "MIX_ENV=prod"
@cog: Set config MIX_ENV=prod

@vanstee: !heroku:config --app flywheel-prod unset MIX_ENV
@cog: Unset config MIX_ENV

@vanstee: !heroku:ps --app flywheel-prod
@cog
NAME   COMMAND             STATUS  STARTED AT
web.1  mix phoenix.server  idle    2016/06/27 21:31:37

@vanstee: !heroku:ps scale "web=2" --app flywheel-prod
@cog: Scaled web process to 2 dynos

@vanstee: !heroku:ps restart web.1 --app flywheel-prod
@cog: Restarted web.1 dyno

@vanstee: !heroku:ps restart --app flywheel-prod
@cog: Restarted all dynos

@vanstee: !heroku:release --app flywheel-prod
@cog:
VERSION  DESCRIPTION     CREATED AT
v10      Deploy 80d7831  patrick@operable.io  2016/06/27 17:57:39
v9       Deploy 80d7831  patrick@operable.io  2016/06/27 17:57:17
v8       Deploy 7002263  mark@operable.io     2016/06/26 15:33:48

@vanstee: !heroku:release rollback v9 --app flywheel-prod
@cog: Rolled back to release v9

@vanstee: !heroku:user --app flywheel-prod
@cog:
EMAIL                ROLE
patrick@operable.io  collaborator
mark@operable.io     owner

@vanstee: !heroku:user add "matt@operable.io" --app flywheel-prod
Added matt@operable.io as a contributor

@vanstee: !heroku:user remove "matt@operable.io" --app flywheel-prod
Removed matt@operable.io as a contributor
```
