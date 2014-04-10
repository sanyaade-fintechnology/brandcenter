# SumUp Status Page

This is the repository for the sumup status page, accessible from
status.sumup.com

## How it works

Edit the __status.json__ file, manually

```js
{
  "updated_at": 1382702870000,
  "overall": {
    "status": "online",
    "details": "All systems are up and running."
  },
  "services": {
    "transactions": {
      "status": "online",
      "details": ""
    },
    "signups": {
      "status": "online",
      "details": ""
    },
    "login": {
      "status": "online",
      "details": ""
    }
  }
}
```

| key        | description              | allowed values |
|------------|--------------------------|----------------|
| updated_at | timestamp in miliseconds | Unix timestamp * 1000. Go to [http://www.convert-unix-time.com](http://www.convert-unix-time.com), copy the timestamp and add three 0s at the end |
| overall    | overall status of the system | |
| status     | target status | online, offline, problems |
| details    | An explination for the status | |
| services   | Set the status for one of the services we have | transactions, signups, login |

### Allowed copy for the overall status details

| Status | Description |
| ------ | ----------- |
| online | All systems are up and running.
| problems | We're currently experiencing a few glitches.
| offline | Systems offline. Our engineers are on it. Please hang on.

## Add Incident Report

Use the `incident_draft.md` as a template

    cp _drafts/incident_draft.md _posts/YYYT-MM-DD-title-of-report.md

Edit the new post and when ready add the new file and push it to GitHub

    git add _posts/YYYT-MM-DD-title-of-report.md
    git ci -m "<Added incident report ...>"
    git push origin HEAD

Go to [http://sumup.github.io](http://sumup.github.io) to view the added report.

You can also use the GitHub web interface for this.
