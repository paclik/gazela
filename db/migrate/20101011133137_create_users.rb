class CreateUsers < ActiveRecord::Migration
 def self.up       
      create_table :users do |t|  
        #t.string :username  
        t.string :email  
        t.string :crypted_password  
        t.string :password_salt  
        t.string :persistence_token  
        t.timestamps
        t.boolean :admin
        ## admin if true user is admin he can create new users pridano
      end  
    end  
    
    def self.down  
      drop_table :users  
    end  
  
  #více policek muzete nalez na http://github.com/binarylogic/authlogic_example
end
