# Date Formmatting

Humans can't seem to agree on a common date format to describe time... which is really really frustrating when you are trying to parse log files.  Here is how we can handle timestamps with ELK

## Step 1: Match the Timestamp

Given the following logs you should create a pattern that matches the timestamp into a specific field like `timestamp`.

```
Jul  2 15:33:04 Eddie's Mac Pro kernel[0]: IO80211AWDLPeerManager::setAwdlOperatingMode Setting the AWDL operation mode from SUSPENDED to AUTO
Jul  2 15:33:04 Eddie's Mac Pro kernel[0]: IO80211AWDLPeerManager::setAwdlAutoMode Resuming AWDL
```

For these logs we would add the following to our patterns list (evertrue-patterns.erb)

```
ET_MAC_SYSLOG_TIMESTAMP %{MONTH}  %{MONTHDAY} %{TIME}
```

For the sake of making this tutorial complete, the final pattern for these logs might be:

```
ET_MAC_SYSLOG %{ET_MAC_SYSLOG_TIMESTAMP:timestamp} %{GREEDYDATA:host} %{NOTSPACE:program}: %{GREEDYDATA:message}
```

## Step 2: Grok the log and Parse the date

We grok the log using the pattern we just created.

```
filter {
    if [type] == 'xyz' {
        grok {
            match => ["%{ET_MAC_SYSLOG}"]
        }

        # date {
        #     match => ["timestamp", "some pattern", "moar patterns", "to try"]
        #     remove_field => ["timestamp"]
        # }
    }
}
```

Note that I have a commented date filter in there two. Enter the meat of this tutorial: Finding the date pattern.

The logstash date filter's match parameter accepts an array where the first element is the field containing the raw timestamp that `grok` added and the rest of the elements in the array are patterns to try to match the field to starting at the 2nd element and moving onwards.

The patterns must be [Joda](http://www.joda.org/joda-time/) compatable formats (not regex). I have built a [handy little CLI tool](https://github.com/evertrue/joda-tester/releases) to test a provided format against a provided timestamp.  This should help drastically!

Add your joda pattern(s) to the `date` filter and you should be good to go (_famous last words._)



