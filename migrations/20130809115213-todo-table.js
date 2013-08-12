module.exports = {
  up: function(migration, DataTypes, done) {
    migration.createTable(
      "todos",
      {
        id:{
          type: DataTypes.INTEGER,
          autoIncrement: true,
          primaryKey: true,
          allowNull: true
        },

        title: DataTypes.STRING,

        createdAt: DataTypes.DATE,
        updatedAt: DataTypes.DATE,
        completedAt: DataTypes.DATE
      }
    )
    done()
  },
  down: function(migration, DataTypes, done) {
    migration.dropTable("todos")
    done()
  }
}