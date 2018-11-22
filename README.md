# sqliteClasses

[![Join the chat at https://gitter.im/sqliteClasses/Lobby](https://badges.gitter.im/sqliteClasses/Lobby.svg)](https://gitter.im/sqliteClasses/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Build Status][TravisBadge]][TravisLink] [![CocoaPods Version][CocoaPodsVersionBadge]][CocoaPodsVersionLink] [![Swift4 compatible][Swift4Badge]][Swift4Link] [![Platform][PlatformBadge]][PlatformLink] [![Carthage compatible][CartagheBadge]][CarthageLink] [![Join the chat at https://gitter.im/osoftz_iOS/sqliteClasses][GitterBadge]][GitterLink]

A type-safe, [Swift][]-language layer over [SQLite3][].

[sqliteClasses][] provides compile-time confidence in SQL statement
syntax _and_ intent.

## Features

 - A pure-Swift interface
 - A type-safe, optional-aware SQL expression builder
 - A flexible, chainable, lazy-executing query layer
 - Automatically-typed data access
 - A lightweight, uncomplicated query and parameter binding interface
 - Developer-friendly error handling and debugging
 - [Full-text search][] support
 - [Well-documented][See Documentation]
 - Extensively tested
 - [SQLCipher][] support via CocoaPods
 - Active support at
   [StackOverflow](http://stackoverflow.com/questions/tagged/sqlite.swift),
   and [Gitter Chat Room](https://gitter.im/osoftz_iOS/sqliteClasses)
   (_experimental_)

[SQLCipher]: https://www.zetetic.net/sqlcipher/
[Full-text search]: Documentation/Index.md#full-text-search
[See Documentation]: Documentation/Index.md#sqliteswift-documentation


## Usage

```swift
/* *********************Creating and Assigning DB************************* */
         createDB(DBName: "First_DB"){
            data, error in
            if data == nil && error == nil{
                print("Table not created")
            }
            else if data == nil{
                print(error!)
            }
            else{
                self.data_base = data!
                print("Database created")
            }
        }
        /* *********************Creating and Assigning DB************************* */
        
        
        /* *********************Creating and print Table************************* */
        let columnNames = ["ID","Name","Age","Mobile","Mail"]
        let dataType = [0,2,2,2,2]
        let unique = [false,false,false,true,true]
        let primay = [true,false,false,false,false]

        let aa = createTable(tableName: "SecondTable", DB: self.data_base, columnNames: columnNames, dataType: dataType, isUnique: unique, isPrimary: primay)
        if (aa.0) {
            print("table created")
        }
        else{
            print("Error while creating table\(aa.1!)")
        }


        let columnNames1 = ["Name","Age","Mobile","Mail"]
        let dataType1 = [2,2,2,2]

        let values = ["Siva","28","96684579","sureskudfgdfgjr@osoftz.com"]

        let bb = insertInTable(tableName: "SecondTable", DB: self.data_base, columnNames: columnNames1, dataType: dataType1, values: values)

        if(bb.0){
            let ID = selectTable(DB: self.data_base, tableName: "SecondTable", dataType: 0, column: "ID")
            let Name = selectTable(DB: self.data_base, tableName: "SecondTable", dataType: 2, column: "Name")
            let Age = selectTable(DB: self.data_base, tableName: "SecondTable", dataType: 2, column: "Age")
            let Mobile = selectTable(DB: self.data_base, tableName: "SecondTable", dataType: 2, column: "Mobile")
            let Email =  selectTable(DB: self.data_base, tableName: "SecondTable", dataType: 2, column: "Mail")
            if Name.1 == nil{
                print("ID \(ID.0!)\nNames array \(Name.0!)\nAge \(Age.0!)\nMobile \(Mobile.0!)\nEmail \(Email.0!)")
            }
        }
        else{
            print("Error while inserting \(bb.1!)")
        }
        /* *********************Creating and print Table************************* */

        /* *********************Upadte and print Table************************* */
        let cc = updateTable(DB: self.data_base, tableName: "SecondTable", where_columName: "ID", where_value: "2", where_dataType: 0, columName: "Name", value: "Sureshkumar", dataType: 2)

        if(cc.0){
            let ID = selectTable(DB: self.data_base, tableName: "SecondTable", dataType: 0, column: "ID")
            let Name = selectTable(DB: self.data_base, tableName: "SecondTable", dataType: 2, column: "Name")
            let Age = selectTable(DB: self.data_base, tableName: "SecondTable", dataType: 2, column: "Age")
            let Mobile = selectTable(DB: self.data_base, tableName: "SecondTable", dataType: 2, column: "Mobile")
            let Email =  selectTable(DB: self.data_base, tableName: "SecondTable", dataType: 2, column: "Mail")
            if Name.1 == nil{
                print("ID \(ID.0!)\nNames array \(Name.0!)\nAge \(Age.0!)\nMobile \(Mobile.0!)\nEmail \(Email.0!)")
            }
        }
        else{
            print("Error while update \(cc.1!)")
        }
        /* *********************Creating and print Table************************* */
        
         let dd :(Bool?, Error?) = deleteRow(DB: self.data_base, tableName: "SecondTable", dataType: 0, column: "ID", value: "1")
        if (dd.0!){
            let ID = selectTable(DB: self.data_base, tableName: "SecondTable", dataType: 0, column: "ID")
            let Name = selectTable(DB: self.data_base, tableName: "SecondTable", dataType: 2, column: "Name")
            let Age = selectTable(DB: self.data_base, tableName: "SecondTable", dataType: 2, column: "Age")
            let Mobile = selectTable(DB: self.data_base, tableName: "SecondTable", dataType: 2, column: "Mobile")
            let Email =  selectTable(DB: self.data_base, tableName: "SecondTable", dataType: 2, column: "Mail")
            if Name.1 == nil{
                print("ID \(ID.0!)\nNames array \(Name.0!)\nAge \(Age.0!)\nMobile \(Mobile.0!)\nEmail \(Email.0!)")
            }
        }
        else{
            print("Error while Delete \(dd.1!)")
        }
```

[Read the documentation][See Documentation] or explore more,
interactively, from the Xcode project’s playground.

![SQLite.playground Screen Shot](Documentation/Resources/playground@2x.png)

For a more comprehensive example, see
[this article][Create a Data Access Layer with sqliteClasses and Swift 2]
and the [companion repository][SQLiteDataAccessLayer2].


[Create a Data Access Layer with sqliteClasses and Swift 2]: http://masteringswift.blogspot.com/2015/09/create-data-access-layer-with.html
[SQLiteDataAccessLayer2]: https://github.com/hoffmanjon/SQLiteDataAccessLayer2/tree/master

## Installation

> _Note:_ sqliteClasses requires Swift 4.1 (and [Xcode][] 9.3).

### Carthage

[Carthage][] is a simple, decentralized dependency manager for Cocoa. To
install sqliteClasses with Carthage:

 1. Make sure Carthage is [installed][Carthage Installation].

 2. Update your Cartfile to include the following:

    ```ruby
    github "osoftz/sqliteClasses"
    ```

 3. Run `carthage update` and
    [add the appropriate framework][Carthage Usage].


[Carthage]: https://github.com/Carthage/Carthage
[Carthage Installation]: https://github.com/Carthage/Carthage#installing-carthage
[Carthage Usage]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application


### CocoaPods

[CocoaPods][] is a dependency manager for Cocoa projects. To install
sqliteClasses with CocoaPods:

 1. Make sure CocoaPods is [installed][CocoaPods Installation]. (sqliteClasses
    requires version 1.0.0 or greater.)

    ```sh
    # Using the default Ruby install will require you to use sudo when
    # installing and updating gems.
    [sudo] gem install cocoapods
    ```

 2. Update your Podfile to include the following:

    ```ruby
    use_frameworks!

    target 'YourAppTargetName' do
        pod 'sqliteClasses'
    end
    ```

 3. Run `pod install --repo-update`.

[CocoaPods]: https://cocoapods.org
[CocoaPods Installation]: https://guides.cocoapods.org/using/getting-started.html#getting-started

### Swift Package Manager

The [Swift Package Manager][] is a tool for managing the distribution of
Swift code.

1. Add the following to your `Package.swift` file:

  ```swift
  dependencies: [
      .package(url: "https://github.com/osoftz/sqliteClasses.git", from: "0.11.5")
  ]
  ```

2. Build your project:

  ```sh
  $ swift build
  ```

[Swift Package Manager]: https://swift.org/package-manager

### Manual

To install sqliteClasses as an Xcode sub-project:

 1. Drag the **SQLite.xcodeproj** file into your own project.
    ([Submodule][], clone, or [download][] the project first.)

    ![Installation Screen Shot](Documentation/Resources/installation@2x.png)

 2. In your target’s **General** tab, click the **+** button under **Linked
    Frameworks and Libraries**.

 3. Select the appropriate **SQLite.framework** for your platform.

 4. **Add**.

Some additional steps are required to install the application on an actual
device:

 5. In the **General** tab, click the **+** button under **Embedded
    Binaries**.

 6. Select the appropriate **SQLite.framework** for your platform.

 7. **Add**.


[Xcode]: https://developer.apple.com/xcode/downloads/
[Submodule]: http://git-scm.com/book/en/Git-Tools-Submodules
[download]: https://github.com/osoftz/sqliteClasses/archive/master.zip


## Communication

[See the planning document] for a roadmap and existing feature requests.

[Read the contributing guidelines][]. The _TL;DR_ (but please; _R_):

 - Need **help** or have a **general question**? [Ask on Stack
   Overflow][] (tag `sqlite.swift`).
 - Found a **bug** or have a **feature request**? [Open an issue][].
 - Want to **contribute**? [Submit a pull request][].

[See the planning document]: /Documentation/Planning.md
[Read the contributing guidelines]: ./CONTRIBUTING.md#contributing
[Ask on Stack Overflow]: http://stackoverflow.com/questions/tagged/sqlite.swift
[Open an issue]: https://github.com/osoftz/sqliteClasses/issues/new
[Submit a pull request]: https://github.com/osoftz/sqliteClasses/fork


## Author

 - [Stephen Celis](mailto:stephen@stephencelis.com)
   ([@stephencelis](https://twitter.com/stephencelis))


## License

sqliteClasses is available under the MIT license. See [the LICENSE
file](./LICENSE.txt) for more information.

## Related

These projects enhance or use sqliteClasses:

 - [SQLiteMigrationManager.swift][] (inspired by
   [FMDBMigrationManager][])


## Alternatives

Looking for something else? Try another Swift wrapper (or [FMDB][]):

 - [Camembert](https://github.com/remirobert/Camembert)
 - [GRDB](https://github.com/groue/GRDB.swift)
 - [SQLiteDB](https://github.com/FahimF/SQLiteDB)
 - [Squeal](https://github.com/nerdyc/Squeal)
 - [SwiftData](https://github.com/ryanfowler/SwiftData)
 - [SwiftSQLite](https://github.com/chrismsimpson/SwiftSQLite)

[Swift]: https://swift.org/
[SQLite3]: http://www.sqlite.org
[sqliteClasses]: https://github.com/osoftz/sqliteClasses

[TravisBadge]: https://img.shields.io/travis/osoftz/sqliteClasses/master.svg?style=flat
[TravisLink]: https://travis-ci.org/

[CocoaPodsVersionBadge]: https://cocoapod-badges.herokuapp.com/v/sqliteClasses/badge.png
[CocoaPodsVersionLink]: http://cocoadocs.org/docsets/sqliteClasses

[PlatformBadge]: https://cocoapod-badges.herokuapp.com/p/sqliteClasses/badge.png
[PlatformLink]: http://cocoadocs.org/docsets/sqliteClasses

[CartagheBadge]: https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat
[CarthageLink]: https://github.com/Carthage/Carthage

[GitterBadge]: https://gitter.im/osoftz_iOS/sqliteClasses
[GitterLink]: https://gitter.im/osoftz_iOS

[Swift4Badge]: https://img.shields.io/badge/swift-4.1-orange.svg?style=flat
[Swift4Link]: https://developer.apple.com/swift/

[SQLiteMigrationManager.swift]: https://github.com/garriguv/SQLiteMigrationManager.swift
[FMDB]: https://github.com/ccgus/fmdb
[FMDBMigrationManager]: https://github.com/layerhq/FMDBMigrationManager
