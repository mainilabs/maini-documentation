class CreateMainiDocumentationApidocs < ActiveRecord::Migration
  def change
    create_table :maini_documentation_apidocs do |t|
      t.string :version
      t.string :type_api
      t.string :url
      t.string :title
      t.string :name
      t.string :group
      t.string :resource
      t.string :action
      t.text :examples
      t.text :success
      t.text :error
      t.string :filename

      t.timestamps null: false
    end
  end
end
