## Mongoid::Includes 3.0.2 (2022-11-03) ##

*  [perf: avoid queries when foreign keys are empty](https://github.com/ElMassimo/mongoid_includes/commit/9f4c0c8bf1560a319c663fae77015c638caec56b)

## Mongoid::Includes 3.0.1 (2022-11-03) ##

*  Allow installing this library with Mongoid `8.0`.

## Mongoid::Includes 3.0.0 (2020-10-29) ##

*  Add support for Mongoid `7.1`.
*  Avoid making a query when the foreign keys are empty.

## Mongoid::Includes 2.1.0 (2017-07-03) ##

*   Fix bug where `includes` ignores the `:with` option if the association is polymorphic. Thanks @nickcherry for the bug report!

## Mongoid::Includes 2.0.0 (2017-01-10) ##

*   Support Mongoid 6.0.1, fixes related to [changes in Mongoid internals](https://github.com/mongodb/mongoid/pull/4326). Thanks @mityakoval and @forumd for the bug reports!

## Mongoid::Includes 1.1.3 (2016-10-17) ##

*   Fix eager loading for [self-referencing associations](https://github.com/ElMassimo/mongoid_includes/pull/6). Thanks @rmachielse!

## Mongoid::Includes 1.1.2 (2016-05-26) ##

*   Change gem dependencies to [support Mongoid 6](https://github.com/ElMassimo/mongoid_includes/pull/3). Thanks @joostverdoorn!

## Mongoid::Includes 1.1.1 (2016-01-12) ##

*   Fix bug with nested includes when the related document is `nil`.

## Mongoid::Includes 1.1.0 (2015-11-04) ##

*   Fix bug with optional polymorphic `belongs_to` relations where the name of the relation does not match an actual class name.

## Mongoid::Includes 1.0.3 (2015-10-10) ##

*   Add support for Mongoid 5.

## Mongoid::Includes 1.0.2 (2015-10-08) ##

*   Fix error when using `merge` or `merge!` with a criteria and `includes`.
*   Replace the internal structure with a Set to be more robust when avoiding duplicate relations.

## Mongoid::Includes 1.0.1 (August 5, 2015) ##

*   Fix error messages for polymorphic includes.
*   Add :with option that receives the criteria that will be used to include documents.

## Mongoid::Includes 1.0.0 (July 30, 2015) ##

*   Initial Version.
