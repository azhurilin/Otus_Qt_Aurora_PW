//=====================*******==========================================*******=====================
    function dbDrop()
    {
        var db = LocalStorage.openDatabaseSync("RequestDatabase", "", "notes", 1000000)
        try {
            db.transaction(function (tx) {
                tx.executeSql("DROP TABLE IF EXISTS  RequestTable");
                console.log("db DROP")

            })
        } catch (err) {
            console.log("Error creating table in database: " + err)
        };
    }
//=====================*******=====================
    function dbInit()
    {
        var db = LocalStorage.openDatabaseSync("RequestDatabase", "", "notes", 1000000)
        try {
            db.transaction(function (tx) {
                tx.executeSql("CREATE TABLE IF NOT EXISTS RequestTable (id INTEGER PRIMARY KEY, date text, request text)");
              //  tx.executeSql("INSERT INTO RequestTable (date, request) VALUES(?, ?)", ["1234", "Test"]);
                console.log("db OK")

            })
        } catch (err) {
            console.log("Error creating table in database: " + err)
        };
    }
//=====================*******=====================
    function dbReadAll()
    {
        var db = LocalStorage.openDatabaseSync("RequestDatabase", "", "notes", 1000000)
        db.transaction(function (tx) {
            var results = tx.executeSql("SELECT id, date, request FROM RequestTable");

          //  for (var i = 0; i < results.rows.length; i++) {
            for (var i = results.rows.length-1; i >=0 ; i--) {

                listModel.append({
                                     id: results.rows.item(i).id,
                                     date: results.rows.item(i).date,
                                     request: results.rows.item(i).request
                                 })
                console.log("dbRead" + results.rows.item(i).id)
            }
        })
    }
//=====================*******=====================
    function dbInsert(Pdate, Prequest)
    {
       var db = LocalStorage.openDatabaseSync("RequestDatabase", "", "notes", 1000000)
       db.transaction(function (tx) {
            tx.executeSql("INSERT INTO RequestTable (date, request) VALUES(?, ?)", [Pdate, Prequest]);

        })

    }
//=====================*******=====================
    function dbUpdate(Pid, Pdate, Prequest)
    {
       var db = LocalStorage.openDatabaseSync("RequestDatabase", "", "notes", 1000000)
       db.transaction(function (tx) {
            tx.executeSql("UPDATE RequestTable SET date = ?, request = ? WHERE id = ?", [Pdate, Prequest, Pid]);

        //   tx.executeSql("UPDATE RequestTable SET date = ?, request = ? WHERE id = 15", [Pdate, Prequest]);

         console.log("dbUpdate " + Pid)

        })

    }


//=====================*******=====================
    function dbDelete(Pid)
    {
       var db = LocalStorage.openDatabaseSync("RequestDatabase", "", "notes", 1000000)
       db.transaction(function (tx) {
            tx.executeSql("DELETE FROM RequestTable WHERE id = ?", [Pid]);

          console.log("dbDelete " + Pid)
        })

    }
//=====================*******==========================================*******=====================
