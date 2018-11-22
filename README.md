# sqliteClasses

[![Build Status][TravisBadge]][TravisLink] [![CocoaPods Version][CocoaPodsVersionBadge]][CocoaPodsVersionLink] [![Swift4 compatible][Swift4Badge]][Swift4Link] [![Platform][PlatformBadge]][PlatformLink] [![Carthage compatible][CartagheBadge]][CarthageLink] [![Join the chat at https://gitter.im/stephencelis/SQLite.swift][GitterBadge]][GitterLink]

A type-safe, [Swift][]-language layer over [SQLite3][].

[SQLite.swift][] provides compile-time confidence in SQL statement
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

[SQLCipher]: https://www.zetetic.net/sqlcipher/
[Full-text search]: Documentation/Index.md#full-text-search
[See Documentation]: Documentation/Index.md#sqliteswift-documentation


## Usage

```swift
import SQLiteClasses

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

  ```

[Swift Package Manager]: https://swift.org/package-manager

### Manual

To install sqliteClasses as an Xcode sub-project:

 1. Drag the **sqliteClasses** file into your own project.
    ([Submodule][], clone, or [download][] the project first.)

    ![Installation Screen Shot](Documentation/Resources/installation@2x.png)

 2. In your target’s **General** tab, click the **+** button under **Linked
    Frameworks and Libraries**.

 3. Select the appropriate **sqliteClasses** for your platform.

 4. **Add**.

Some additional steps are required to install the application on an actual
device:

 5. In the **General** tab, click the **+** button under **Embedded
    Binaries**.

 6. Select the appropriate **sqliteClasses.framework** for your platform.

 7. **Add**.


[Xcode]: https://developer.apple.com/xcode/downloads/
[Submodule]: http://git-scm.com/book/en/Git-Tools-Submodules


## Communication

[See the planning document] for a roadmap and existing feature requests.

[Read the contributing guidelines][]. The _TL;DR_ (but please; _R_):

 - Need **help** or have a **general question**? [Ask on Stack
   Overflow][] (tag `sqliteClasses`).
 - Found a **bug** or have a **feature request**? [Open an issue][].
 - Want to **contribute**? [Submit a pull request][].

[See the planning document]: /Documentation/Planning.md
[Read the contributing guidelines]: ./CONTRIBUTING.md#contributing
[Ask on Stack Overflow]: http://stackoverflow.com/questions/tagged/sqliteClasses


## Author

 - [Osoftz](mailto:ios@osoftz.com)
   


## License

sqliteClasses is available under the MIT license. See [the LICENSE
file](./LICENSE.txt) for more information.

## Related

These projects enhance or use sqliteClasses:

 - [sqliteClasses][]


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

[CocoaPodsVersionBadge]: https://cocoapod-badges.herokuapp.com/v/SQLite.swift/badge.png
[CocoaPodsVersionLink]: http://cocoadocs.org/docsets/SQLite.swift

[PlatformBadge]: https://cocoapod-badges.herokuapp.com/p/SQLite.swift/badge.png
[PlatformLink]: http://cocoadocs.org/docsets/SQLite.swift

[CartagheBadge]: https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat
[CarthageLink]: https://github.com/Carthage/Carthage

[Swift4Badge]: https://img.shields.io/badge/swift-4.1-orange.svg?style=flat
[Swift4Link]: https://developer.apple.com/swift/

[SQLiteMigrationManager.swift]: https://github.com/garriguv/SQLiteMigrationManager.swift
[FMDB]: https://github.com/ccgus/fmdb
[FMDBMigrationManager]: https://github.com/layerhq/FMDBMigrationManager


