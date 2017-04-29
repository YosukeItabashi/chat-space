# DB設計

## messages table
| column     | type        | options                    |
|:-----------|------------:|:--------------------------:|
| body       |      text   | null: false                |
| image      |      string |                            |
| user_id    |      integer| foreign_key: true          |
| group_id   |      integer| foreign_key: true          |
| timestamps |             | null: false                |


## Association
belongs_to :users
belongs_to :groups


## users table
| column     | type        | options                    |
|:-----------|------------:|:--------------------------:|
| name       | string      |index: true, null: false    |
| mail       | stting      |null: false                 |


##Association
has_many :groups, through: members
has_many :messages
has_many :members


##groups table
| column     | type        | options                    |
|:-----------|------------:|:--------------------------:|
| name       | string      |index: true, null: false    |
| members_id | integer     |null: false                 |


##Association
has_many :users, thorough: members
has_many :messages
has_many :members


##members table
| column     | type        | options                    |
|:-----------|------------:|:--------------------------:|
| groups_id  | integer     |foreign_key: true           |
| users_id   | integer     |foreign_key: true           |


##Association
belongs_to :groups
belongs_to :users

