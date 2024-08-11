json.extract! user, :id, :username

json.sqid user.attachable_sgid
json.content render(partial: "users/user", locals: {user: user}, formats: [:html])
