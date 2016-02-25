## Ruby on Rails, Api

### Körinstruktioner

Jag använder den [färdiga vagrant-fil](https://github.com/thajo/ruby-on-rails-vagrant) som John tillhandahåller. Det finns också en instruktionsfilm [här](http://orion.lnu.se/pub/education/course/1DV450/vt16/vagrantup.mp4). En förutsättning är att man har [Vagrant](https://www.vagrantup.com/downloads.html) och [Virtual box](https://www.virtualbox.org/wiki/Downloads) (eller liknande) installerat. Det har fungerat utmärkt för mig på Windows 10. 

1. Ladda ner/klona repot. 
2. `vagrant up` i repots root-katalog för att installera för första gången. Det tar ganska länge.
3. `vagrant ssh` för att logga in på den virtuella maskinen. 
4. `cd /vagrant/rails-application/`
5. `bundle install --without production`
6. `rake db:setup` för att initialisera databasen med användare och applikationer genererade med ett gem som heter Faker.
7. `rake test` för att köra testsviten. Alla test bör bli gröna. 
8. `rails s -b 0.0.0.0` för att kicka igång servern. 
9. `http://localhost:3000/`
10. För att logga in som admin. E-post: `admin@mail.com`, Lösenord: `password`.
11. `exit`följt av `vagrant halt` för att avsluta. 

### Api instruktioner
I applikationen finns en sida som beskriver hur api:et fungerar. Den nås via `/api/guide`.

Det finns också en [Postman-fil](https://github.com/me222wm/1dv450_me222wm/blob/master/ApiTestCollection.json.postman_collection) som samlar de anrop som går att göra mot api:et. Det ska fungera out of the box. Möts du av `401 Unauthorized` eller något annat fel: pröva att använda en annan api-nyckel eller ändra autentiserings-tokenet i request headern. Resursägares uppgifter finns i postman-filen och i seeds-filen. 

