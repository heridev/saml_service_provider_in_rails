# An easy to use/install and run SAML Service Provider server in Ruby on Rails 6

## How to use this server right away:
1. git clone git@github.com:heridev/saml_service_provider_in_rails.git
2. cd saml_service_provider_in_rails
3. bundle install
4. rake db:create
5. rake db:migrate
6. rails s -b 'ssl://localhost:3000?key=newCertWithPasswordLocahostKey.key&cert=newCertWithPasswordLocahostCert.crt'

Now you can visit the URL
```
https://localhost:3000/users/saml/sign_in
```

That will generate the `SAMLRequest` token and it will redirect you to the Identity Provider (IdP) Server as you need to logged-in first in order to access any Service Provider resources (I'll be sharing the Identity Provider server on Rails as well, so you can get the entire workflow working :))

NOTE: As we don't want to get errors with OpenSSL, we are running it with https and then in Chrome we can ignore that warning and proceed with the access to localhost

As you can see I created those certificates using the following command:
```
openssl req -x509 -sha256 -nodes -days 3650 -passout pass:foobar -newkey rsa:2048 -keyout newCertWithPasswordLocahostKey.key -out newCertWithPasswordLocahostCert.crt
```

The passphrase is:
```
foobar
```

This one is important, cause you will need this value when setting up your Identity Provider in Rails, here
[I'll push it in a minute so you can have both parts working]

