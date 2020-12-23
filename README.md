# README

# テーブル設計

## users テーブル

| Column             | Type   | Options      |
| ------------------ | ------ | ------------ |
| nickname           | string | null: false  |
| email              | string | unique: true |
| encrypted_password | string | null: false  |
| family_name        | string | null: false  |
| first_name         | string | null: false  |
| family_name_kana   | string | null: false  |
| first_name_kana    | string | null: false  |
| birth_day          | date   | null: false  |

### Association

- has_many :items
- has_many :orderhistories

## items テーブル

| Column        | Type        | Options                        |
| ------------- | ----------- | ------------------------------ |
| name          | string      | null: false                    |
| price         | integer     | null: false                    |
| description   | text        | null: false                    |
| category_id   | integer     | null: false                    |
| status_id     | integer     | null: false                    |
| cost_id       | integer     | null: false                    |
| prefecture_id | integer     | null: false                    |
| day_id        | integer     | null: false                    |
| user          | references  | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :orderhistory

## destination テーブル

| Column                    | Type       | Options                            |
| ------------------------- | ---------- | ---------------------------------- |
| post_code                 | string     | null: false                        |
| prefecture_id             | integer    | null: false                        |
| city                      | string     | null: false                        |
| address                   | string     | null: false                        |
| building_name             | string     |                                    |
| phone_number              | string     | null: false                        |
| orderhistory              | references | null: false, foreign_key: true     |

### Association

- belongs_to :orderhistory

## orderhistory テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one  :destination