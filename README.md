# テーブル設計

## usersテーブル

| Column             | Type   | Options                   |
| ------------------ | -------| ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| nickname           | string | null: false               |
| first_name         | text   | null: false               |
| last_name          | text   | null: false               |
| first_name_kana    | text   | null: false               |
| last_name_kana     | text   | null: false               |
| birth_day          | date   | null: false               |

### Association

- has_many :items
- has_many :orders


## itemsテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| content            | string     | null: false                    |
| price              | int        | null: false                    |
| user               | references | null: false, foreign_key: true |
| category_id        | int        | null: false                    |
| condition_id       | int        | null: false                    |
| payment_id         | int        | null: false                    |
| prefecture_id      | int        | null: false                    |
| days_id            | int        | null: false                    |

### Association

- belongs_to :user
- has_one :order


## ordersテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| price              | int        | null: false                    |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :send


## sendsテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post_code          | string     | null: false                    |
| city               | string     | null: false                    |
| address            | string     | null: false                    |
| building_name      | string     |                                |
| phone_number       | string     | null: false                    |
| order              | references | null: false, foreign_key: true |
| prefecture_id      | int        | null: false                    |

### Association

- belongs_to :order
