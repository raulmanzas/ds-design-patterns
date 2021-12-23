## Ambassador pattern example

This folder contains an example of an ambassador container being used with abstract the connection to multiple redis instances from an application container.

The application container here is simulated using redis-client, but it could be any application that needs to connect to a redis instance, or many redis instances. In both cases, the application just needs to talk do localhost:6080, and the ambassador container is in charge to proxy the request to redis instances.

More about the pattern:
- https://docs.microsoft.com/en-us/azure/architecture/patterns/ambassador
