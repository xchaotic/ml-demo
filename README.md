# Lech REST Demo

This demo shows interaction with Marklogic 8 using custom REST endpoints, using generated FpML as an example application.

I. Installation

1. Install Marklogic
2. Go to Appserver configuration - usually http://localhost:8001/appserver-summary.xqy?section=group
3. Create a new HTTP Server - http://localhost:8001/add-http-servers.xqy?webDAV=false&section=group
4. Give it some name and leave all default values except:
root - specify the location where you unpacked the attached files (or cloned from github) (ensure that ML has rights to read)
port - so it doesn't clash with something else - I used 8009 on my local machine
database - I used the default Documents one to keep things simple but feel free to create a dedicated one.
authentication and default user - for demo purposes I used application level and admin but to make things harder security can be enabled
error handler - /xquery/rest/error-handler.xqy
url rewriter - /xquery/rest/rewriter.xqy

(I can send that as XML config for easier deployments.)
5. Configure ranged index for fpml:rate 
In my configuration that was Databases -> Documents -> Element Range Indexes -> Add http://localhost:8001/add-range-element-indexes.xqy?section=database&database=983927919163513127 (of course the id will vary)
scalar type - double
namespace uri - 
localname - rate
range value positions - false (default)
invalid values - reject (default) http://www.fpml.org/2007/FpML-4-4

That's it!

II. Usage:
After that queries should work in browser or in Postman:
HTTP GET http://localhost:8009/load - populate the database with 10000 documents
GET http://localhost:8009/rates - get exchange rates for all the documents and display the first 100. It will also return the query time, which is really fast, thanks to the index. The result is XML