// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _UserBean implements Bean<User> {
  final id = StrField('id');
  final username = StrField('username');
  final password = StrField('password');
  final salt = StrField('salt');
  final role = IntField('role');
  final phoneNumber = StrField('phone_number');
  final email = StrField('email');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        username.name: username,
        password.name: password,
        salt.name: salt,
        role.name: role,
        phoneNumber.name: phoneNumber,
        email.name: email,
      };
  User fromMap(Map map) {
    User model = User();
    model.id = adapter.parseValue(map['id']);
    model.username = adapter.parseValue(map['username']);
    model.password = adapter.parseValue(map['password']);
    model.salt = adapter.parseValue(map['salt']);
    model.role = adapter.parseValue(map['role']);
    model.phoneNumber = adapter.parseValue(map['phone_number']);
    model.email = adapter.parseValue(map['email']);

    return model;
  }

  List<SetColumn> toSetColumns(User model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(id.set(model.id));
      ret.add(username.set(model.username));
      ret.add(password.set(model.password));
      ret.add(salt.set(model.salt));
      ret.add(role.set(model.role));
      ret.add(phoneNumber.set(model.phoneNumber));
      ret.add(email.set(model.email));
    } else if (only != null) {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(username.name)) ret.add(username.set(model.username));
      if (only.contains(password.name)) ret.add(password.set(model.password));
      if (only.contains(salt.name)) ret.add(salt.set(model.salt));
      if (only.contains(role.name)) ret.add(role.set(model.role));
      if (only.contains(phoneNumber.name))
        ret.add(phoneNumber.set(model.phoneNumber));
      if (only.contains(email.name)) ret.add(email.set(model.email));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.username != null) {
        ret.add(username.set(model.username));
      }
      if (model.password != null) {
        ret.add(password.set(model.password));
      }
      if (model.salt != null) {
        ret.add(salt.set(model.salt));
      }
      if (model.role != null) {
        ret.add(role.set(model.role));
      }
      if (model.phoneNumber != null) {
        ret.add(phoneNumber.set(model.phoneNumber));
      }
      if (model.email != null) {
        ret.add(email.set(model.email));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addStr(id.name, primary: true, isNullable: false);
    st.addStr(username.name, length: 20, isNullable: false);
    st.addStr(password.name, length: 32, isNullable: false);
    st.addStr(salt.name, length: 30, isNullable: false);
    st.addInt(role.name, isNullable: false);
    st.addStr(phoneNumber.name, length: 11, isNullable: true);
    st.addStr(email.name, length: 30, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(User model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    var retId = await adapter.insert(insert);
    if (cascade) {
      User newModel;
      if (model.avatar != null) {
        newModel ??= await find(model.id);
        avatarBean.associateUser(model.avatar, newModel);
        await avatarBean.insert(model.avatar, cascade: cascade);
      }
    }
    return retId;
  }

  Future<void> insertMany(List<User> models,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(insert(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data = models
          .map((model) =>
              toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
          .toList();
      final InsertMany insert = inserters.addAll(data);
      await adapter.insertMany(insert);
      return;
    }
  }

  Future<dynamic> upsert(User model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    var retId = await adapter.upsert(upsert);
    if (cascade) {
      User newModel;
      if (model.avatar != null) {
        newModel ??= await find(model.id);
        avatarBean.associateUser(model.avatar, newModel);
        await avatarBean.upsert(model.avatar, cascade: cascade);
      }
    }
    return retId;
  }

  Future<void> upsertMany(List<User> models,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(upsert(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
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
  }

  Future<int> update(User model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    final ret = adapter.update(update);
    if (cascade) {
      User newModel;
      if (model.avatar != null) {
        if (associate) {
          newModel ??= await find(model.id);
          avatarBean.associateUser(model.avatar, newModel);
        }
        await avatarBean.update(model.avatar,
            cascade: cascade, associate: associate);
      }
    }
    return ret;
  }

  Future<void> updateMany(List<User> models,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(update(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
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
  }

  Future<User> find(String id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    final User model = await findOne(find);
    if (preload && model != null) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(String id, {bool cascade = false}) async {
    if (cascade) {
      final User newModel = await find(id);
      if (newModel != null) {
        await avatarBean.removeByUser(newModel.id);
      }
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<User> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<User> preload(User model, {bool cascade = false}) async {
    model.avatar = await avatarBean.findByUser(model.id,
        preload: cascade, cascade: cascade);
    return model;
  }

  Future<List<User>> preloadAll(List<User> models,
      {bool cascade = false}) async {
    await OneToXHelper.preloadAll<User, Avatar>(
        models,
        (User model) => [model.id],
        avatarBean.findByUserList,
        (Avatar model) => [model.userId],
        (User model, Avatar child) => model.avatar = child,
        cascade: cascade);
    return models;
  }

  AvatarBean get avatarBean;
}
