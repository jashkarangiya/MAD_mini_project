/*
*  TABLES: DBProvider
*  Function: Structure of the application tables
*/

class DBTables {

  static const String favorites = '''
    CREATE TABLE IF NOT EXISTS Cities(
        name TEXT PRIMARY KEY,
        lon REAL,
        lat REAL,
        country TEXT,
        state TEXT
      )
  ''';

}