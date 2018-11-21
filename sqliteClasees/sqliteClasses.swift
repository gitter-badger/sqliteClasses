//
//  sqliteClasses.swift
//  sqliteClasees
//
//  Created by Developers on 17/11/18.
//  Copyright © 2018 osoftz. All rights reserved.
//

import Foundation
import SQLite

var db : Connection!

public func database() -> Connection{
    do{
        try db = Connection.init()
         return db
    }
    catch{
        return database()
    }
    
}


public func createDB(DBName : String, completionHandler: @escaping (Connection?, Error?) -> ()){
    do{
        let documentDir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL =  documentDir.appendingPathComponent(DBName).appendingPathExtension("sqlite3")
        let db = try Connection(fileURL.path)
        completionHandler(db, nil)
            
    }catch{
        print(error)
        completionHandler(nil, error)
        }
}
    
public func createTable(tableName: String, DB:Connection, columnNames:[String], dataType:[Int], isUnique:[Bool]?=nil, isPrimary:[Bool]?=nil) -> (Bool,Error?) {
        
        let createTable =  Table(tableName).create { (table) in
            if columnNames.count != 0{
                for i in 0 ... columnNames.count - 1{
                    switch dataType[i] {
                    case 0 :
                        if isUnique?[i] ?? false{
                            table.column(Expression<Int>(columnNames[i]), unique: isUnique?[i] ?? false)
                        }
                        else if isPrimary?[i] ?? false{
                            table.column(Expression<Int>(columnNames[i]), primaryKey : isPrimary?[i] ?? false)
                        }
                        else{
                            table.column(Expression<Int>(columnNames[i]))
                        }
                    case 1 :
                        if isUnique?[i] ?? false{
                            table.column(Expression<Date>(columnNames[i]), unique: isUnique?[i] ?? false)
                        }
                        else if isPrimary?[i] ?? false{
                            table.column(Expression<Date>(columnNames[i]), primaryKey : isPrimary?[i] ?? false)
                        }
                        else{
                            table.column(Expression<Date>(columnNames[i]))
                        }
                    default:
                        if isUnique?[i] ?? false{
                            table.column(Expression<String>(columnNames[i]), unique: isUnique?[i] ?? false)
                        }
                        else if isPrimary?[i] ?? false{
                            table.column(Expression<String>(columnNames[i]), primaryKey : isPrimary?[i] ?? false)
                        }
                        else{
                            table.column(Expression<String>(columnNames[i]))
                        }
                    }
                    
                }
            }
            
        }
        
        do{
            try DB.run(createTable)
            return (true,nil)
        }
        catch{
            print(error)
            return (false,error)
        }
}
    
public func insertInTable(tableName:String, DB:Connection, columnNames:[String], dataType:[Int], values:[Any])  -> (Bool,Error?){
    let tab = Table(tableName)
    var InsertValue = [Setter]()
    var result : (Bool, Error?)!
    if columnNames.count != 0{
        for i in 0 ... columnNames.count - 1{
            switch dataType[i] {
            case 0 :
                InsertValue.append(Expression<Int>(columnNames[i]) <- values[i] as! Int)
            case 1 :
                InsertValue.append(Expression<Date>(columnNames[i]) <- values[i] as! Date)
            case 2 :
                InsertValue.append(Expression<String>(columnNames[i]) <- String(describing: values[i]))
            default: break
            }
        }
            do{
                var insValue : Insert!
                insValue = tab.insert(InsertValue)
                try DB.run(insValue)
                result = (true, nil)
            }
                catch{
                    print(error)
                    result = (false, error)
                }
        }
        return result
    }
    
public func updateTable(DB:Connection, tableName:String, where_columName:String, where_value:String,where_dataType:Int,columName:String, value:String,dataType:Int) -> (Bool,Error?){
    let tab = Table(tableName)
    var filter_table : Table!
    var updateTab : Update!
    var result : (Bool, Error?)!
    print("Inside Update funtion")
    switch where_dataType {
    case 0 :
        filter_table = tab.filter(Expression<Int>(where_columName) == Int(where_value)!)
        
    case 1 :
        filter_table = tab.filter(Expression<Date>(where_columName) == dateFormatter(stringDate: where_value, format: "MM/dd/yyyy"))
        
    case 2 :
        filter_table = tab.filter(Expression<String>(where_columName) == where_value)
        
    default: break
    }
    
    switch dataType {
    case 0:
        updateTab = filter_table.update(Expression<Int>(columName) <- Int(value)!)
    case 1:
        updateTab = filter_table.update(Expression<Date>(columName) <- dateFormatter(stringDate: value, format: "MM/dd/yyyy"))
    case 2:
        updateTab = filter_table.update(Expression<String>(columName) <- value)
    default:
        break
    }
        do{
            try DB.run(updateTab)
            result = (true, nil)
        }catch{
            print(error)
            result = (false, error)
        }
    
    return result
}

public func selectTable(DB:Connection, tableName:String, dataType:Int, column:String)->([String]?,Error?)  {
    let tab = Table(tableName)
    
    do{
        let xx = try DB.prepare(tab)
        var values = [String]()
        
        for row in xx{
            switch dataType{
            case 0:
                values.append(String(describing: row[Expression<Int>(column)]))
            case 1:
                values.append(String(describing: row[Expression<Date>(column)]))
            case 2:
                values.append(String(describing: row[Expression<String>(column)]))
            default:
                break
            }
        }
        return (values,nil)
    }
    catch{
        print(error)
        return (nil,error)
    }
}

public func deleteRow(DB:Connection, tableName:String, dataType:Int, column:String, value:String) -> (Bool?,Error?){
   let tab = Table(tableName)
    var filter_table : Table!
    do{
        switch dataType {
        case 0 :
            filter_table = tab.filter(Expression<Int>(column) == Int(value)!)
            
        case 1 :
            filter_table = tab.filter(Expression<Date>(column) == dateFormatter(stringDate: value, format: "MM/dd/yyyy"))
            
        case 2 :
            filter_table = tab.filter(Expression<String>(column) == value)
            
        default: break
        }
        
        let xx = filter_table.delete()
        
        try DB.run(xx)
        return (true,nil)
        
    }catch{
        print(error)
        return (nil,error)
    }
}


func dateFormatter(stringDate:String, format : String)-> Date
{
    let formatter = DateFormatter()
    formatter.dateFormat = format //"HH:mm:ss"
    let formattedDate = formatter.date(from: stringDate)
    return formattedDate!
}
