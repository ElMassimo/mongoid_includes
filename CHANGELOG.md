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
