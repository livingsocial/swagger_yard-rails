# SwaggerYard-Rails Changelog

## 0.3.0 -- 16-12-2015 ##

* Don't clobber controller/model lookup paths in initializer if they have
  already been set
* Look up routes using the Rails router; allows DRYing routes by omitting @path
  tags in most cases.
* Fix `swagger:json` rake task

## 0.2.0 -- 20-10-2015 ##

* Support for Swagger's Spec v2

    *Nick Sieger <@nicksieger>*

* Remove support for Spec v1

    *Tony Pitale <@tpitale>*

## 0.1.0 -- 15-10-2015 ##

* Add Engine from SwaggerYard
* Update specs to make requests of rails app

    *Tony Pitale <@tpitale>*
