# digi14_geeks_event_app(GE App)

Flutter coding challenge

## Getting Started

Flutter Geeks Event (GE App) is a US sports and musical events browsing solution that helps the user search & view their favorite events
with city, state etc. user can also mark an event as favorite so that they can remember the event later when the revisit.

The project was designed using flutter's popular Bloc state management pattern & it uses MVP as architectural pattern. the project also contains Unit tests for core business logic classes
such as Event presenter and event repository.
API Information
The endpoint to use on Seat Geek is free and publicly accessible, but you will need to
register for a Seat Geek account and obtain an API key to use it. Details can be found at
http://platform.seatgeek.com/

We can pass in the url param of q which will correspond to the search query. For example,
the below query will give us a result set for the term Texas Ranger.

https://api.seatgeek.com/2/events?client_id=&lt;your client id&gt;&amp;q=Texas+Ranger
Full API documentation is available at http://platform.seatgeek.com/#events

For any  queries : dinesh.masthaiah@gmail.com