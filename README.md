# An easy to use/install and run SAML Service Provider server in Ruby on Rails 6

If you want to read more about `SAML` and `SSO`, you can take a look at this tech spec
https://gist.github.com/heridev/25f842d1e5b87870d987ee128f9dbee2

And this is the architecture of both parts (Service Provider and Identity Provider):
![image](https://user-images.githubusercontent.com/1863670/81245406-837ef700-8fda-11ea-9f31-a5a25b2bf645.png)

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

At this point you will get an error after you are redirected to the URL:
```
https://localhost:3030/idp/saml/auth?SAMLRequest=hVPLbtswEPwV3XhSxEpJHBCWA
```

Because you need to set up the `Identity Provider` first, in order to do that you can follow the instructions included in the `saml_identity_provider_rails` repository:
> https://github.com/heridev/saml_identity_provider_rails

That will generate the `SAMLRequest` token and it will redirect you to the Identity Provider (IdP) Server as you need to logged-in first in order to access any Service Provider resources (I'll be sharing the Identity Provider server on Rails as well, so you can get the entire workflow working :))

### Certificates and OpenSSL

NOTE: As we don't want to get errors with OpenSSL, we are running it with https and then in Chrome, we can ignore that warning and proceed with the access to localhost

As you can see I created those certificates using the following command:
```
openssl req -x509 -sha256 -nodes -days 3650 -passout pass:foobar -newkey rsa:2048 -keyout newCertWithPasswordLocahostKey.key -out newCertWithPasswordLocahostCert.crt
```

The passphrase is:
```
foobar
```

## Saml settings for production/staging
If you run this in development, you do not need to set any special values, but once you want to deploy this repository to staging/production you will need to set the following env variable:

```
ASSERTION_CONSUMER_SERVICE_URL
ISSUER
IDP_SSO_TARGET_URL
```

These are the default values:
```
saml_settings.assertion_consumer_service_url = 'https://localhost:3000/users/saml/auth'
saml_settings.issuer = 'https://localhost:3000/users/saml/metadata'
saml_settings.idp_sso_target_url = 'https://localhost:3030/idp/saml/auth'
saml_settings.idp_cert_fingerprint = 'E4:FC:60:40:03:A2:33:9D:AA:9D:50:59:F2:04:F0:3C:88:62:3B:F1:EB:D8:4C:FF:9C:D1:93:07:03:F7:C9:74
```

