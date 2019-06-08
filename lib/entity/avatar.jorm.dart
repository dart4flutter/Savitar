// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _AvatarBean implements Bean<Avatar> {
  final id = IntField('id');
  final userId = StrField('user_id');
  final avatar = StrField('avatar');
  final avatarPath = StrField('avatar_path');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        userId.name: userId,
        avatar.name: avatar,
        avatarPath.name: avatarPath,
      };
  Avatar fromMap(Map map) {
    Avatar model = Avatar();
    model.id = adapter.parseValue(map['id']);
    model.userId = adapter.parseValue(map['user_id']);
    model.avatar = adapter.parseValue(map['avatar']);
    model.avatarPath = adapter.parseValue(map['avatar_path']);

    return model;
  }

  List<SetColumn> toSetColumns(Avatar model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(id.set(model.id));
      ret.add(userId.set(model.userId));
      ret.add(avatar.set(model.avatar));
      ret.add(avatarPath.set(model.avatarPath));
    } else if (only != null) {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(userId.name)) ret.add(userId.set(model.userId));
      if (only.contains(avatar.name)) ret.add(avatar.set(model.avatar));
      if (only.contains(avatarPath.name))
        ret.add(avatarPath.set(model.avatarPath));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.userId != null) {
        ret.add(userId.set(model.userId));
      }
      if (model.avatar != null) {
        ret.add(avatar.set(model.avatar));
      }
      if (model.avatarPath != null) {
        ret.add(avatarPath.set(model.avatarPath));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, isNullable: false);
    st.addStr(userId.name,
        foreignTable: userBean.tableName, foreignCol: 'id', isNullable: false);
    st.addStr(avatar.name, length: 100, isNullable: true);
    st.addStr(avatarPath.name, length: 200, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Avatar model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Avatar> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Avatar model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<Avatar> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
    }
    final UpsertMany upsert = upserters.addAll(data);
    await adapter.upsertMany(upsert);
    return;
  }

  Future<int> update(Avatar model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Avatar> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.id.eq(model.id));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<Avatar> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Avatar> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<Avatar> findByUser(String userId,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.userId.eq(userId));
    return findOne(find);
  }

  Future<List<Avatar>> findByUserList(List<User> models,
      {bool preload = false, bool cascade = false}) async {
// Return if models is empty. If this is not done, all the records will be returned!
    if (models == null || models.isEmpty) return [];
    final Find find = finder;
    for (User model in models) {
      find.or(this.userId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByUser(String userId) async {
    final Remove rm = remover.where(this.userId.eq(userId));
    return await adapter.remove(rm);
  }

  void associateUser(Avatar child, User parent) {
    child.userId = parent.id;
  }

  UserBean get userBean;
}
