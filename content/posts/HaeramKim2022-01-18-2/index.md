---
title: "Chapter 9. Creating ReST Interface"
date: "2022-01-18"
tags:
- "HaeramKim"
- "BuildYourOwnIoTPlatform"
---
> NOTE: this notes are from “Build Your Own IoT Platform” by Anand Tamboli. And I can’t speak english very well, so some sentences or word might be inappropriate and might have some misunderstandings.  

## Make “ReST/GET Records Based on Condition” Funtionality
* It’s simple; Fetch some records by `topic-like`, `payload-like`, `count`.
![](index/Screen%20Shot%202022-01-17%20at%209.37.19%20AM.png)
* `HTTP in` node: Set method as `GET` and URL as `/records/topic-like/:topic/payload-like/:payload/last/:count`.
* `function` node:
```
// Create query

// if no authentication filter defined or available
// set the default value as 1
if(!msg.req.authFilter)
    msg.req.authFilter = 1;

// wildcard used for API query is * and this needs to be converted into SQL wildcard character %
msg.topic = "SELECT id,topic,payload,timestamp" +
            " FROM thingsData WHERE" +
            " topic LIKE '" + msg.req.params.topic.
            replace(/\*/g, "%") + "'" +
            " AND" +
            " payload LIKE '" + msg.req.params.payload.
            replace(/\*/g, "%") + "'" +
            " AND deleted=0" +
            " AND (" + msg.req.authFilter + ")" +
            " ORDER BY ID DESC" +
            " LIMIT " + msg.req.params.count + ";";

return msg;
```
* Note that we set default of `authFilter` to 1. It means we’re gonna allow all un-authorized user for now.
* Check `" AND (" + msg.req.authFilter + ")" +` part: If `authFilter` is 1, this means `true`, so this query will works normally, but if it’s 0, this means `false`, so this query will fetch nothing.
- - - -
## Deleting from DB
* Note that all the APIs has same structure and procedure; all the differences between them are just ReST API endpoints and DB query.
* There are two ways to accomplish this: _Recoverable_ and _Permanent_.
### Recoverable Deletation
![](index/Screen%20Shot%202022-01-17%20at%2011.14.24%20PM.png)
* Recoverable deletation is just updating value of `deleted` column to 1.
* Since this is just a updating the DB, so i think it’s better to use `PATCH` HTTP method instead of `GET` method.
### Permanent Deletation
![](index/Screen%20Shot%202022-01-18%20at%203.55.06%20PM.png)
* Permanent deletation is deleting the instance inside of DB.
* Unlike _Recoverable Deletation_, i’m decide to use `DELETE` HTTP method to do it.
- - - -
## Microservice Utilities
![](index/Screen%20Shot%202022-01-18%20at%2010.46.59%20PM.png)
### ReST/GET Current Timetamp
* This functionality coordinates with **M2** API.
* Set ReST Endpoint to `/timestamp`, method to `GET`.
* And set `function` node to:
```
msg.payload = {
    timestamp: (new Date()).getTime().toString()
};
return msg;
```
### ReST/GET Random Code
* This functionality coordinates with **M3** API.
* Set ReST Endpoint to `/randomcode/:len`, method to `GET`.
	* `:len` represents length of the random code.
* And set `function` node to:
```
var randomString = function(length) {
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    for(var i = 0; i < length; i++) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    }
    return text;
}

msg.payload = {
    code: randomString(msg.req.params.len)
};

return msg;
```
### ReST/GET UUID
* This functionality coordinates with **M4** API.
* For this functionality, we have to install `node-red-contrib-uuid` plugin to generate UUID.
* After that, all we have to do is just pass the generated UUID to HTTP response.
* So, set ReST Endpoint to `/uuid`, method to `GET`.
* And set `function` node to:
```
// Prepare response
msg.payload = {
    uuid: msg.payload
};

return msg;
```
### And other…
* To implement **M5**, **M6** API, we need to use [SendGrid](https://sendgrid.com) and [Twilio](https://www.twilio.com).
* But to use both of ‘em, we have to pay some money. So, let’s skip these for now.
