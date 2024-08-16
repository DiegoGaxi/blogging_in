class AddUnaccentExtension < ActiveRecord::Migration[7.0]
  def up
    # Habilitar la extensión unaccent en PostgreSQL
    execute 'CREATE EXTENSION IF NOT EXISTS unaccent;'
  end

  def down
    # Deshabilitar la extensión unaccent en PostgreSQL (esto puede causar problemas si otras tablas dependen de la extensión)
    execute 'DROP EXTENSION IF EXISTS unaccent;'
  end
end
