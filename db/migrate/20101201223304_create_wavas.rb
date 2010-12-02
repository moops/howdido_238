class CreateWavas < ActiveRecord::Migration
  def self.up
    create_table :wavas do |t|
      t.integer :age
      t.float :m1m
      t.float :m2m
      t.float :m3m
      t.float :m5k
      t.float :m8k
      t.float :m10k
      t.float :m12k
      t.float :m15k
      t.float :m10m
      t.float :m20k
      t.float :mM2
      t.float :m25k
      t.float :m30k
      t.float :mM
      t.float :m50k
      t.float :m50m
      t.float :m100k
      t.float :f1m
      t.float :f2m
      t.float :f3m
      t.float :f5k
      t.float :f8k
      t.float :f10k
      t.float :f12k
      t.float :f15k
      t.float :f10m
      t.float :f20k
      t.float :fM2
      t.float :f25k
      t.float :f30k
      t.float :fM
      t.float :f50k
      t.float :f50m
      t.float :f100k

      t.timestamps
    end
  end

  def self.down
    drop_table :wavas
  end
end
