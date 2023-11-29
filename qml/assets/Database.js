//=====================*******==========================================*******=====================
    function dbDrop()
    {
        var db = LocalStorage.openDatabaseSync("TaskDatabase", "", "tasks", 1000000)
        try {
            db.transaction(function (tx) {
                tx.executeSql("DROP TABLE IF EXISTS  TaskTable");
                tx.executeSql("DROP TABLE IF EXISTS  UserTable");

                console.log("db DROP")

            })
        } catch (err) {
            console.log("Error creating table in database: " + err)
        };
    }
//=====================*******=====================
    function dbInit()
    {
        var db = LocalStorage.openDatabaseSync("TaskDatabase", "", "tasks", 1000000)
        try {
            db.transaction(function (tx) {
                tx.executeSql("CREATE TABLE IF NOT EXISTS TaskTable (id INTEGER PRIMARY KEY, date TEXT, task TEXT, owner TEXT)");
               // tx.executeSql("INSERT INTO TaskTable (date, task, owner) VALUES(?, ?, ?)", ["1234", "Test", "JohnSmith@gmail.com"]);

                tx.executeSql("CREATE TABLE IF NOT EXISTS UserTable (id INTEGER PRIMARY KEY, name TEXT, surname TEXT, login TEXT, password TEXT, news INTEGER)");


                console.log("db OK")

            })
        } catch (err) {
            console.log("Error creating table in database: " + err)
        };
    }
//=====================*******=====================
    function dbReadAllTask()
    {
        var db = LocalStorage.openDatabaseSync("TaskDatabase", "", "tasks", 1000000)
        db.transaction(function (tx) {
            var results = tx.executeSql("SELECT id, date, task FROM TaskTable");

           for (var i = results.rows.length-1; i >=0 ; i--) {

                listModel.append({
                                     id: results.rows.item(i).id,
                                     date: results.rows.item(i).date,
                                     request: results.rows.item(i).task
                                 })
                console.log("dbRead" + results.rows.item(i).id)
            }
        })
    }
//=====================*******=====================
    function dbInsertTask(Pdate, Ptask)
    {
       var db = LocalStorage.openDatabaseSync("TaskDatabase", "", "tasks", 1000000)
       db.transaction(function (tx) {
            tx.executeSql("INSERT INTO TaskTable (date, task) VALUES(?, ?)", [Pdate, Ptask]);

        })

    }
//=====================*******=====================
    function dbUpdateTask(Pid, Pdate, Ptask)
    {
       var db = LocalStorage.openDatabaseSync("TaskDatabase", "", "tasks", 1000000)
       db.transaction(function (tx) {
            tx.executeSql("UPDATE TaskTable SET date = ?, task = ? WHERE id = ?", [Pdate, Ptask, Pid]);

           console.log("dbUpdate " + Pid)

        })

    }
//=====================*******=====================
    function dbDeleteTask(Pid)
    {
       var db = LocalStorage.openDatabaseSync("TaskDatabase", "", "tasks", 1000000)
       db.transaction(function (tx) {
          tx.executeSql("DELETE FROM TaskTable WHERE id = ?", [Pid]);

          console.log("dbDeleteTask " + Pid)
        })

    }
//=====================*******=====================
    function dbInsertUser(Pname, Psurname, Plogin, Ppassword, Pnews)
    {
       var db = LocalStorage.openDatabaseSync("TaskDatabase", "", "tasks", 1000000)
       db.transaction(function (tx) {
          tx.executeSql("INSERT INTO UserTable (name, surname, login, password, news) VALUES(?, ?, ?, ?, ?)", [Pname, Psurname, Plogin, Ppassword, Pnews]);

    })

}
//=====================*******=====================
    function dbDeleteUser(Pid)
    {
     var db = LocalStorage.openDatabaseSync("TaskDatabase", "", "tasks", 1000000)
     db.transaction(function (tx) {
       tx.executeSql("DELETE FROM UserTable WHERE id = ?", [Pid]);

      console.log("dbDeleteUser " + Pid)
    })

}
//=====================*******=====================
function dbReadUser(Plogin)
{
    console.log(Plogin)
    var db = LocalStorage.openDatabaseSync("TaskDatabase", "", "tasks", 1000000)
    var ulogin = "";
    var upass = "";

    db.transaction(function (tx) {
        var results = tx.executeSql("SELECT id, login, password FROM UserTable  WHERE login = ?", [Plogin]);

       if (results.rows.length > 0)
          {
           ulogin = results.rows.item(0).login;
           upass = results.rows.item(0).password
           console.log(results.rows.item(0).id +" "+ ulogin +" "+ upass);
          }

    })

    return [ulogin, upass];
}
//=====================*******=====================
function dbReadAllUser()
{
    var db = LocalStorage.openDatabaseSync("TaskDatabase", "", "tasks", 1000000)
    db.transaction(function (tx) {
        var results = tx.executeSql("SELECT id, login, password FROM UserTable");

       for (var i = results.rows.length-1; i >=0 ; i--) {

            console.log("dbUser " + results.rows.item(i).id +" "+ results.rows.item(i).login +" "+ results.rows.item(i).password  )
        }
    })
}
//=====================*******=====================






//=====================*******==========================================*******=====================
