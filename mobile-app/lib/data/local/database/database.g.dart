// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  LocationDao _locationDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Location` (`pk` INTEGER PRIMARY KEY AUTOINCREMENT, `id` TEXT, `name` TEXT, `address` TEXT, `type` TEXT, `checkIn` INTEGER, `checkOut` INTEGER, `checkedIn` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  LocationDao get locationDao {
    return _locationDaoInstance ??= _$LocationDao(database, changeListener);
  }
}

class _$LocationDao extends LocationDao {
  _$LocationDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _locationInsertionAdapter = InsertionAdapter(
            database,
            'Location',
            (Location item) => <String, dynamic>{
                  'pk': item.pk,
                  'id': item.id,
                  'name': item.name,
                  'address': item.address,
                  'type': item.type,
                  'checkIn': _dateTimeConverter.encode(item.checkIn),
                  'checkOut': _dateTimeConverter.encode(item.checkOut),
                  'checkedIn':
                      item.checkedIn == null ? null : (item.checkedIn ? 1 : 0)
                },
            changeListener),
        _locationUpdateAdapter = UpdateAdapter(
            database,
            'Location',
            ['pk'],
            (Location item) => <String, dynamic>{
                  'pk': item.pk,
                  'id': item.id,
                  'name': item.name,
                  'address': item.address,
                  'type': item.type,
                  'checkIn': _dateTimeConverter.encode(item.checkIn),
                  'checkOut': _dateTimeConverter.encode(item.checkOut),
                  'checkedIn':
                      item.checkedIn == null ? null : (item.checkedIn ? 1 : 0)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Location> _locationInsertionAdapter;

  final UpdateAdapter<Location> _locationUpdateAdapter;

  @override
  Stream<List<Location>> findAllLocations() {
    return _queryAdapter.queryListStream('SELECT * FROM Location',
        queryableName: 'Location',
        isView: false,
        mapper: (Map<String, dynamic> row) => Location(
            row['pk'] as int,
            row['id'] as String,
            row['name'] as String,
            row['address'] as String,
            row['type'] as String,
            _dateTimeConverter.decode(row['checkIn'] as int),
            _dateTimeConverter.decode(row['checkOut'] as int),
            row['checkedIn'] == null ? null : (row['checkedIn'] as int) != 0));
  }

  @override
  Stream<List<Location>> findCheckedOutLocations() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Location WHERE checkedIn = 0 ORDER BY checkOut DESC',
        queryableName: 'Location',
        isView: false,
        mapper: (Map<String, dynamic> row) => Location(
            row['pk'] as int,
            row['id'] as String,
            row['name'] as String,
            row['address'] as String,
            row['type'] as String,
            _dateTimeConverter.decode(row['checkIn'] as int),
            _dateTimeConverter.decode(row['checkOut'] as int),
            row['checkedIn'] == null ? null : (row['checkedIn'] as int) != 0));
  }

  @override
  Stream<List<Location>> findCheckedInLocations() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Location WHERE checkedIn = 1 ORDER BY checkIn DESC',
        queryableName: 'Location',
        isView: false,
        mapper: (Map<String, dynamic> row) => Location(
            row['pk'] as int,
            row['id'] as String,
            row['name'] as String,
            row['address'] as String,
            row['type'] as String,
            _dateTimeConverter.decode(row['checkIn'] as int),
            _dateTimeConverter.decode(row['checkOut'] as int),
            row['checkedIn'] == null ? null : (row['checkedIn'] as int) != 0));
  }

  @override
  Future<Location> findLocationById(String id) async {
    return _queryAdapter.query('SELECT * FROM Location WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Location(
            row['pk'] as int,
            row['id'] as String,
            row['name'] as String,
            row['address'] as String,
            row['type'] as String,
            _dateTimeConverter.decode(row['checkIn'] as int),
            _dateTimeConverter.decode(row['checkOut'] as int),
            row['checkedIn'] == null ? null : (row['checkedIn'] as int) != 0));
  }

  @override
  Future<void> insertLocation(Location location) async {
    await _locationInsertionAdapter.insert(location, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateLocation(Location location) {
    return _locationUpdateAdapter.updateAndReturnChangedRows(
        location, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
