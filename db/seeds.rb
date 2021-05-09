User.create!(name:  "鈴木 一郎",
    password:              "foobar",
    password_confirmation: "foobar")

10.times do |n|
    Memo.create!(name: "離乳食名",
                 description: "こうやって作ります。",
                 user_id: 1)
end