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
| updated_at | timestamp in miliseconds | |
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

## Cron setup

We need to add this cronjob entry:

    */29 * * * *  ruby scripts/sumup_supervisor.rb

