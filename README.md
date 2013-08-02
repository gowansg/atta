Atta
=====

The What
--------

Atta is another time tracking application.

The Why
-------

There is nothing really innovative here. The project's primary purpose is to 
help me learn and explore Ruby, along with anything else I discover and find
interesting.

The How (at this point in time)
-------------------------------

The original plan was to create a website using Sinatra and some sort of ORM on the backend, with a JavaScript framework like AngularJs or Ember on the frontend.  I also wanted to incorporate OpenID as the authentication mechanism.  However, I changed direction and I decided to instead focus on designing a RESTful API first.  The idea being that I'll have a solid backend I can leverage when I decide to explore new platforms and languages.  


I'm still using Sinatra for the API, but with OAuth for authentication, DataMapper as my ORM, and PostgreSQL as my DB of choice.  Once I have my API flushed out, I plan on dogfooding it by building a Rails app to consume it. The Rails app will also allow me to explore a JavaScript framework like the two I mentioned earlier.  Perhaps I'll even get around to building a mobile app.  Who knows?  Let's see if I can finish the API first.
