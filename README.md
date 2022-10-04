## 設計するときに十分に気をつけたこと

アプリの完成を最優先にした。
そのため、実装が複雑になりうる仕様は避け、できるだけシンプルな機能を設計するように心がけた

テスト(RSpec)をしっかり書くことを意識した。

---

## 開発パート

- section1: 会員管理関係
- section2: 部屋を作れる
- section3: 人を部屋に呼べる
- section4: 部屋に情報を投稿できる

=

- section5: 通知・設定関係
  - 5-1: LINE との連携
  - 5-2: 通知関係
  - 5-3: 設定関連

---

## section2,3 に関する要件・ルール

- 部屋のパスワードはなし
- ユーザーは全員登録が必要
- ユーザーは 1 つの部屋とだけ繋がれる
- 部屋作成者は他の部屋には入れない
- 部屋作成者は、他人を部屋に招待できる（招待方法は下）
- 誰かが作った部屋は、招待を受けないと行けない、つまり部屋の存在すら他ユーザーは知れない
- 部屋が決まっているユーザーはログイン後すぐその部屋の URL に行く

招待方法に関して

- 招待方法
- 部屋設定画面に部屋の URL と定型文のフォームがあり、
- コピーボタンがある
- それを招待したい人に送る
- 受け取った人が URL に飛ぶと、会員登録と入室申請ボタンがあり、まず会員登録を促される
- 会員登録を終えると飛んできた URL に戻り、申請ボタン押下を促される
- （上のためには飛んできた URL を会員登録中も保持する必要がある）
- これでできるか？>>>戻りたいページの URL をセッションに保存し、create 後にそのページに遷移する設定にします。
  def new
  session[:previous_url] = request.referer # ここで前ページセッションを保存
  end

  def create
  redirect_to session[:previous_url] # create 後に遷移させる
  end

- 申請ボタンを押すと作成者に申請が行き、承諾 or 拒否ができる
- ※通知管理画面が必要

---

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...
