user = User.create(email: "test@example.com", password: "123456")
Project.create(title: "Project 1", user_id: user.id)
