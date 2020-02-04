// Objection Docs:
// http://vincit.github.io/objection.js/

const db = require('../db');
const Model = require('objection').Model;

Model.knex(db.knex);

class UserPermission extends Model {
    $beforeInsert() {
        this.created_on = Model.raw(db.nowRaw());
        this.modified_on = Model.raw(db.nowRaw());
    }

    $beforeUpdate() {
        this.modified_on = Model.raw(db.nowRaw());
    }

    static get name() {
        return 'UserPermission';
    }

    static get tableName() {
        return 'user_permission';
    }
}

module.exports = UserPermission;
