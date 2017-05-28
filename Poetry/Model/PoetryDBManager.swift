//
//  PoetryDBManager.swift
//  SwiftCase
//
//  Created by 伍腾飞 on 2017/5/21.
//  Copyright © 2017年 Shepherd. All rights reserved.
//

import UIKit

// DAO 诗词数据访问接口
class PoetryDBManager: NSObject {
    
    static let shared = PoetryDBManager()
    
    private var dbPath: String!
    
    private var db: OpaquePointer? {
        get {
            // 数据库的操作句柄
            var db: OpaquePointer?
            let ret = sqlite3_open_v2(dbPath, &db, SQLITE_OPEN_CREATE|SQLITE_OPEN_READWRITE, nil)
            if ret == SQLITE_OK {
                return db
            }
            print("打开数据库失败：\(sqlite3_errmsg(db))")
            return nil
        }
    }
    
    override init() {
        super.init()
        
        // 移动数据库到Documents中, 会自动备份(iTunes,iCloud)
        var srcPath: String?
        var desPath: String?
        if let path = Bundle.main.path(forResource: "Poetry", ofType: "bundle") {
            srcPath = path + "/sqlite.db"
        }
        if let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            desPath = path + "/poetry.sqlite"
        }
        guard srcPath != nil && desPath != nil else {
            return
        }
        if !FileManager.default.fileExists(atPath: desPath!) {
            try? FileManager.default.copyItem(atPath: srcPath!, toPath: desPath!)
        }
        dbPath = desPath!
    }
    
    // 获取诗词所有类型 五言古诗、七言律诗
    class func getPoetryKinds() -> [PoetryKind]? {
        var kinds: [PoetryKind]?
        /**
         扩展：
            void* 指针 C语言中的万能指针
            void* p; 可以指向任何类型的数据
            p = &x; 取变量x的首地址赋给指针p
            先强转成int*的指针(指定内存访问方式，以4个字节为单位读取数据->数据类型)，再取值
            printf("%d\n", *(int*)p);
            根据不同类型，指定相应的指针内存访问方式(C中的泛型)
            void output(void* p, Type t);
         回到Swift中：
            C语言中的数据类型在Swift中是对应的 
                eg：public typealias CInt = Int32 已知的数据类型
            OpaquePointer不透明指针，用于描述C/C++中不确定类型的指针
            未知的数据类型COpaquePointer归为UnsafePointer
         */
        if let db = PoetryDBManager.shared.db {
            let sql = "SELECT D_KIND, D_NUM, D_INTROKIND, D_INTROKIND2 FROM T_KIND"
            var stmt: OpaquePointer?
            
            if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK {
                kinds = []
                
                while sqlite3_step(stmt) == SQLITE_ROW {
                    let kind = PoetryKind()
                    kind.kindName = String(cString: sqlite3_column_text(stmt, 0)!)
                    kind.kindID = Int(String(cString: sqlite3_column_text(stmt, 1)!)) ?? 0
                    kind.kindDesc = String(cString: sqlite3_column_text(stmt, 2)!)
                    kind.kindComment = String(cString: sqlite3_column_text(stmt, 3)!)
                    kinds!.append(kind)
                }
                
                sqlite3_finalize(stmt)
            }
        }
        return kinds
    }
    
    // 查询此分类下的所有古诗
    class func getPoetries(by kindName: String) -> [Poetry]? {
        var poetries: [Poetry]?
        if let db = PoetryDBManager.shared.db {
            let sql = "SELECT D_ID, D_TITLE, D_SHI, D_INTROSHI, D_AUTHOR, D_KIND FROM T_SHI WHERE D_KIND='\(kindName)'"
            var stmt: OpaquePointer?
            
            if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK {
                poetries = []
                
                while sqlite3_step(stmt) == SQLITE_ROW {
                    let poetry = Poetry()
                    poetry.ID = Int(String(cString: sqlite3_column_text(stmt, 0)!)) ?? 0
                    poetry.title = String(cString: sqlite3_column_text(stmt, 1)!)
                    poetry.content = String(cString: sqlite3_column_text(stmt, 2)!)
                    poetry.desc = String(cString: sqlite3_column_text(stmt, 3)!)
                    poetry.author = String(cString: sqlite3_column_text(stmt, 4)!)
                    poetry.kindName = String(cString: sqlite3_column_text(stmt, 5)!)
                    poetries!.append(poetry)
                }
                
                sqlite3_finalize(stmt)
            }
            sqlite3_close_v2(db)
        }
        return poetries
    }
    
    // 根据分类删除古诗
    class func deletePoetry(byKindName kindName: String) -> Bool {
        var flag = false
        if let db = PoetryDBManager.shared.db {
            let sql = "DELETE FROM T_SHI WHERE D_KIND='\(kindName)'"
            var stmt: OpaquePointer?
            
            if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK {
                
                if sqlite3_step(stmt) == SQLITE_DONE {
                    flag = true
                }

                sqlite3_finalize(stmt)
            }
            sqlite3_close_v2(db)
        }
        return flag
    }
    
    // 删除某一首古诗
    class func deletePoetry(byID ID: Int) -> Bool {
        var flag = false
        if let db = PoetryDBManager.shared.db {
            let sql = "DELETE FROM T_SHI WHERE D_ID=\(ID)"
            var stmt: OpaquePointer?
            
            if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK {
                
                if sqlite3_step(stmt) == SQLITE_DONE {
                    flag = true
                }
                
                sqlite3_finalize(stmt)
            }
            sqlite3_close_v2(db)
        }
        return flag
    }
    
}
